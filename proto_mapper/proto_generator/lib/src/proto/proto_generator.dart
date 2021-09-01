import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:proto_annotations/proto_annotations.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';
import 'package:source_gen/source_gen.dart';

import 'field_code_generator.dart';
import 'field_code_generators/external_proto_name.dart';
import 'field_descriptor.dart';

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

    var imports = StringBuffer();
    for (var externalProtoName in externalProtoNames) {
      imports.writeln('import \'$externalProtoName\';');
    }

    final className = classElement.name;

    final messages = '''
message $_prefix$className
{
$fieldDeclarations
}   

message ${_prefix}ListOf$className
{
  repeated $_prefix$className items = 1;
}   
    ''';

    var ret = '''
syntax = "proto3";

$imports

$packageDeclaration

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

Proto _hydrateAnnotation(ConstantReader reader, {String prefix = ''}) {
  var ret = Proto(
    prefix: reader.read('prefix').literalValue as String? ?? prefix,
    includeFieldsByDefault:
        reader.read('includeFieldsByDefault').literalValue as bool,
    packageName: reader.read('packageName').literalValue as String? ?? '',
  );

  return ret;
}
