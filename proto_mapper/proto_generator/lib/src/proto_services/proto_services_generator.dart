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
    var packageName = annotation.packageName != '' ? '' : _defaultPackage;

    final packageDeclaration = packageName != '' ? 'package $packageName;' : '';

    var methodDescriptors = _getMethodDescriptors(classElement, annotation);

    var ret =
        _generateForClass(classElement, methodDescriptors, packageDeclaration);

    return ret;
  }

  String _generateForClass(
    ClassElement classElement,
    Iterable<MethodDescriptor> methodDescriptors,
    String packageDeclaration,
  ) {
    var methodBuffer = StringBuffer();
    var externalProtoNames = <String>[];

    for (var methodDescriptor in methodDescriptors) {
      final methodName = methodDescriptor.name;
      final asnc = methodDescriptor.returnTypeIsFuture ? 'await' : '';
      final parameterType = _getTypeName(methodDescriptor.parameterType);
      final gParameterType =
          _getPrefixedTypeName(methodDescriptor.parameterType);
      final gReturnType = _getPrefixedTypeName(methodDescriptor.returnType);
      final resultLine = !methodDescriptor.returnType.isList
          ? '''final protoResult = result.toProto();'''
          : '''final protoResult = $gReturnType()..items.addAll(result.map((i) => i.toProto()));''';

      methodBuffer.writeln('''
  @override Future<$gReturnType> $methodName(ServiceCall call, $gParameterType request,) async {
    final service = createService(call);

    final entity = request.to$parameterType();
    final result = $asnc service.$methodName(entity);
    $resultLine
    return protoResult;
  }

''');

      final externalProtoName =
          _getExternalProtoName(methodDescriptor.returnType);

      if (externalProtoName != '' &&
          !externalProtoNames.contains(externalProtoName)) {
        externalProtoNames.add(externalProtoName);
      }
    }

    var imports = StringBuffer();
    for (var externalProtoName in externalProtoNames) {
      imports.writeln('import \'$externalProtoName\';');
    }

    final className = classElement.name;
    final serviceClassName = className.endsWith('Base')
        ? className.substring(0, className.length - 4)
        : className;

    var ret = '''

typedef ${serviceClassName}Factory = $className Function(ServiceCall call);



class $_prefix$serviceClassName extends $_prefix${serviceClassName}Base
{
  final ${serviceClassName}Factory factory;
  final void Function(ServiceCall call)? onMetadataHandler;

  $_prefix$serviceClassName(
    this.factory, [
    this.onMetadataHandler,
  ]);

    @override
  void \$onMetadata(ServiceCall call) {
    if (onMetadataHandler != null) {
      onMetadataHandler!(call);
    }
  }


  $className createService(ServiceCall call) {
    final ret = factory(call);
    return ret;
  }

  $methodBuffer
} 
''';
    return ret;
  }

  String _getTypeName(DartType type) {
    final itemType = type.finalType;
    final displayName = itemType.getDisplayString(withNullability: false);
    return displayName;
  }

  String _getPrefixedTypeName(DartType type) {
    final itemType = type.finalType;
    final listOf = type.isList ? 'ListOf' : '';
    final displayName = itemType.getDisplayString(withNullability: false);
    final ret = '$_prefix$listOf$displayName';
    return ret;
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
