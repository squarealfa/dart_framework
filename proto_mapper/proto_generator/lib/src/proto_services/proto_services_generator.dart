import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:proto_annotations/proto_annotations.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';
import 'package:source_gen/source_gen.dart';

import 'method_descriptor.dart';

class ProtoServicesGenerator extends GeneratorForAnnotation<ProtoServices> {
  final BuilderOptions options;
  late String _prefix;
  late String _defaultPackage;

  ProtoServicesGenerator(this.options) {
    var config = options.config;
    _prefix = config['prefix'] as String? ?? 'G';
    _defaultPackage = config['package'] as String? ?? '';
  }

  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader reader, BuildStep buildStep) {
    var annotation = _hydrateAnnotation(reader, prefix: _prefix);

    var classElement = element.asClassElement();
    if (classElement.kind.name == 'ENUM') return '';

    var packageName = annotation.packageName != '' ? '' : _defaultPackage;

    final packageDeclaration = packageName != '' ? 'package $packageName;' : '';

    var ret = _generateForClass(
      classElement,
      annotation,
      packageDeclaration,
    );

    return ret;
  }

  String _generateForClass(
    ClassElement classElement,
    ProtoServices annotation,
    String packageDeclaration,
  ) {
    final externalProtoNames = <String>[];
    var methodDescriptors = _getMethodDescriptors(classElement, annotation);
    final methodDeclarations =
        _createMethodDeclarations(methodDescriptors, externalProtoNames);

    var imports = StringBuffer();
    for (var externalProtoName in externalProtoNames) {
      imports.writeln('import \'$externalProtoName\';');
    }

    final className = classElement.name;
    final serviceClassName = className.endsWith('Base')
        ? className.substring(0, className.length - 4)
        : className.endsWith('Interface')
            ? className.substring(0, className.length - 'Interface'.length)
            : className;

    final services = methodDeclarations == ''
        ? ''
        : '''
service $_prefix$serviceClassName
{
$methodDeclarations
}   
    ''';

    var ret = '''
syntax = "proto3";

$imports

$packageDeclaration

$services
 
''';
    return ret;
  }

  String _createMethodDeclarations(
    Iterable<MethodDescriptor> methodDescriptors,
    List<String> externalProtoNames,
  ) {
    var methodBuffer = StringBuffer();

    for (var methodDescriptor in methodDescriptors) {
      final methodName = methodDescriptor.pascalName;
      final parameterType = _getTypeName(methodDescriptor.parameterType);
      final returnType = _getTypeName(methodDescriptor.returnType);

      methodBuffer.writeln(
          '''    rpc $methodName ($parameterType) returns ($returnType);''');

      final returnExternalProtoName =
          _getExternalProtoName(methodDescriptor.returnType);
      if (returnExternalProtoName != '' &&
          !externalProtoNames.contains(returnExternalProtoName)) {
        externalProtoNames.add(returnExternalProtoName);
      }
      final parmExternalProtoName =
          _getExternalProtoName(methodDescriptor.parameterType);
      if (parmExternalProtoName != '' &&
          !externalProtoNames.contains(parmExternalProtoName)) {
        externalProtoNames.add(parmExternalProtoName);
      }
    }
    return methodBuffer.toString();
  }

  String _getExternalProtoName(DartType type) {
    var fieldElementType = type.finalType;
    var segments = fieldElementType.element?.source?.uri.pathSegments.toList();
    if (segments == null) {
      return '';
    }
    var lastSrc = segments.lastIndexOf('src');
    if (lastSrc != -1) segments.removeRange(0, lastSrc + 1);
    var fileName = segments[segments.length - 1];
    fileName = fileName.substring(0, fileName.length - 4) + 'proto';
    segments[segments.length - 1] = fileName;
    final ret = segments.join('/');
    return ret;
  }

  String _getTypeName(DartType type) {
    final itemType = type.finalType;
    final listOf = (type.isList || type.isSet) ? 'ListOf' : '';
    final displayName = itemType.getDisplayString(withNullability: false);
    final ret = '$_prefix$listOf$displayName';
    return ret;
  }
}

Iterable<MethodDescriptor> _getMethodDescriptors(
  ClassElement classElement,
  ProtoServices annotation,
) {
  final methods = classElement.getSortedMethods();
  final methodDescriptors = methods
      .map((fieldElement) => MethodDescriptor.fromMethodElement(
            classElement,
            fieldElement,
            annotation,
          ))
      .where((element) => element.isProtoIncluded);
  return methodDescriptors;
}

ProtoServices _hydrateAnnotation(ConstantReader reader, {String prefix = ''}) {
  var ret = ProtoServices(
    prefix: reader.read('prefix').literalValue as String? ?? prefix,
    packageName: reader.read('packageName').literalValue as String? ?? '',
  );

  return ret;
}
