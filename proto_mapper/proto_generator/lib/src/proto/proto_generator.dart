import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:proto_annotations/proto_annotations.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';
import 'package:source_gen/source_gen.dart';

import 'field_code_generator.dart';
import 'field_code_generators/external_proto_name.dart';
import 'field_descriptor.dart';
import 'method_descriptor.dart';

class ProtoGenerator extends GeneratorForAnnotation<Proto> {
  final BuilderOptions options;
  late String _prefix;
  late String _defaultPackage;

  ProtoGenerator(this.options) {
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

    var ret = classElement.kind.name == 'ENUM'
        ? _generateForEnum(
            classElement,
            annotation,
            packageDeclaration,
          )
        : _generateForClass(
            classElement,
            annotation,
            packageDeclaration,
          );

    return ret;
  }

  String _generateForClass(
    ClassElement classElement,
    Proto annotation,
    String packageDeclaration,
  ) {
    final externalProtoNames = <String>[];
    var fieldDescriptors = _getFieldDescriptors(classElement, annotation);
    final fieldDeclarations =
        _createFieldDeclarations(fieldDescriptors, externalProtoNames);
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

    final messages = fieldDeclarations == '' && methodDeclarations != ''
        ? ''
        : '''
message $_prefix$className
{
$fieldDeclarations
}   

message ${_prefix}ListOf$className
{
  repeated $_prefix$className items = 1;
}   
    ''';

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
$messages

 
''';
    return ret;
  }

  String _createFieldDeclarations(
    Iterable<FieldDescriptor> fieldDescriptors,
    List<String> externalProtoNames,
  ) {
    final fieldBuffer = StringBuffer();
    var lineNumber = 1;
    for (var fieldDescriptor in fieldDescriptors) {
      var fieldCodeGenerator = FieldCodeGenerator.fromFieldDescriptor(
        fieldDescriptor,
        lineNumber++,
      );

      var fieldLine = fieldCodeGenerator.fieldLine;
      fieldBuffer.writeln(
          '  ${fieldDescriptor.isRepeated ? 'repeated ' : ''}$fieldLine');
      if (fieldDescriptor.isNullable) {
        fieldBuffer.writeln('  ${fieldCodeGenerator.hasValueLine}');
        lineNumber++;
      }

      if (fieldCodeGenerator is! ExternalProtoName) continue;
      var externalProtoName =
          (fieldCodeGenerator as ExternalProtoName).externalProtoName;
      if (externalProtoName != null &&
          !externalProtoNames.contains(externalProtoName)) {
        externalProtoNames.add(externalProtoName);
      }
    }

    return fieldBuffer.toString();
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
    final listOf = type.isList ? 'ListOf' : '';
    final displayName = itemType.getDisplayString(withNullability: false);
    final ret = '$_prefix$listOf$displayName';
    return ret;
  }

  String _generateForEnum(
    ClassElement classElement,
    Proto annotation,
    String packageDeclaration,
  ) {
    var fieldBuffer = StringBuffer();
    var fieldDescriptors = _getFieldDescriptors(
      classElement,
      annotation,
    );

    var lineNumber = 0;
    for (var fieldDescriptor in fieldDescriptors) {
      fieldBuffer
          .writeln('  ${fieldDescriptor.protoFieldName} = ${lineNumber++};');
    }
    var className = classElement.name;
    var ret = '''
syntax = "proto3";
    
$packageDeclaration
    
enum $_prefix$className
{
$fieldBuffer
}   
     
message Nullable$_prefix$className
{
  bool hasValue = 1;
  $_prefix$className value = 2;
}
 
''';

    return ret;
  }
}

Iterable<FieldDescriptor> _getFieldDescriptors(
    ClassElement classElement, Proto annotation) {
  final fieldSet = classElement.getSortedFieldSet();
  final fieldDescriptors = fieldSet
      .map((fieldElement) => FieldDescriptor.fromFieldElement(
            classElement,
            fieldElement,
            annotation,
          ))
      .where((element) => element.isProtoIncluded);
  return fieldDescriptors;
}

Iterable<MethodDescriptor> _getMethodDescriptors(
  ClassElement classElement,
  Proto annotation,
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

Proto _hydrateAnnotation(ConstantReader reader, {String prefix = ''}) {
  var ret = Proto(
    prefix: reader.read('prefix').literalValue as String? ?? prefix,
    includeFieldsByDefault:
        reader.read('includeFieldsByDefault').literalValue as bool,
    packageName: reader.read('packageName').literalValue as String? ?? '',
  );

  return ret;
}
