import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:proto_annotations/proto_annotations.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';
import 'package:source_gen/source_gen.dart';

import 'field_code_generator.dart';
import 'field_code_generators/external_proto_name.dart';
import 'field_descriptor.dart';

abstract class ProtoGeneratorBase<TProto extends ProtoBase>
    extends GeneratorForAnnotation<TProto> {
  final BuilderOptions options;
  late String _prefix;
  late String _defaultPackage;

  ProtoGeneratorBase(this.options) {
    var config = options.config;
    _prefix = config['prefix'] as String? ?? 'G';
    _defaultPackage = config['package'] as String? ?? '';
  }

  TProto? hydrateAnnotation(ConstantReader reader, {String prefix});
  String get filePrefix => '';

  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader reader, BuildStep buildStep) {
    var annotation = hydrateAnnotation(reader, prefix: _prefix);
    if (annotation == null) return '';

    var classElement = element.asClassElement();
    var packageName = annotation.packageName != '' ? '' : _defaultPackage;

    final packageDeclaration =
        packageName != '' ? 'package ${packageName};' : '';

    var fieldDescriptors = _getFieldDescriptors(classElement, annotation);

    String ret = classElement.kind.name == "ENUM"
        ? _generateForEnum(classElement, fieldDescriptors, packageDeclaration)
        : _generateForClass(classElement, fieldDescriptors, packageDeclaration);

    return ret;
  }

  String _generateForClass(
    ClassElement classElement,
    Iterable<FieldDescriptor> fieldDescriptors,
    String packageDeclaration,
  ) {
    var fieldBuffer = StringBuffer();
    List<String> externalProtoNames = [];

    int lineNumber = 1;
    for (var fieldDescriptor in fieldDescriptors) {
      var fieldCodeGenerator = FieldCodeGenerator.fromFieldDescriptor(
        fieldDescriptor,
        lineNumber++,
        filePrefix,
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

    var imports = StringBuffer();
    for (var externalProtoName in externalProtoNames) {
      imports.writeln('import \'$externalProtoName\';');
    }

    var className = classElement.name;
    var ret = '''
syntax = "proto3";

$imports

$packageDeclaration

message $_prefix$className
{
$fieldBuffer
}   

 
''';
    return ret;
  }

  String _generateForEnum(
    ClassElement classElement,
    Iterable<FieldDescriptor> fieldDescriptors,
    String packageDeclaration,
  ) {
    var fieldBuffer = StringBuffer();

    int lineNumber = 0;
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
    ClassElement classElement, ProtoBase annotation) {
  final fieldSet = classElement.getSortedFieldSet();
  final fieldDescriptors = fieldSet
      .map((fieldElement) => FieldDescriptor.fromFieldElement(
            classElement,
            fieldElement!,
            annotation,
          ))
      .where((element) => element.isProtoIncluded);
  return fieldDescriptors;
}
