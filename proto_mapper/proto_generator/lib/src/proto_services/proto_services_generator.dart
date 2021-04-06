import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:proto_annotations/proto_annotations.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';
import 'package:source_gen/source_gen.dart';

import 'field_code_generator.dart';
import 'field_code_generators/external_proto_name.dart';
import 'field_descriptor.dart';

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

    var fieldDescriptors = _getFieldDescriptors(classElement, annotation);

    var ret =
        _generateForClass(classElement, fieldDescriptors, packageDeclaration);

    return ret;
  }

  String _generateForClass(
    ClassElement classElement,
    Iterable<FieldDescriptor> fieldDescriptors,
    String packageDeclaration,
  ) {
    var methodBuffer = StringBuffer();
    var externalProtoNames = <String>[];

    var lineNumber = 1;
    for (var fieldDescriptor in fieldDescriptors) {
      var fieldCodeGenerator = FieldCodeGenerator.fromFieldDescriptor(
        fieldDescriptor,
        lineNumber++,
      );

      var fieldLine = fieldCodeGenerator.fieldLine;
      methodBuffer.writeln(
          '  ${fieldDescriptor.isRepeated ? 'repeated ' : ''}$fieldLine');
      if (fieldDescriptor.isNullable) {
        methodBuffer.writeln('  ${fieldCodeGenerator.hasValueLine}');
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

service $_prefix${className}Services
{
$methodBuffer
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
