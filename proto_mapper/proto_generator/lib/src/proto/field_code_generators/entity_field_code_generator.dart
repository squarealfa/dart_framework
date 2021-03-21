import 'package:proto_annotations/proto_annotations.dart';
import 'package:source_gen/source_gen.dart';

import '../field_code_generator.dart';
import '../field_descriptor.dart';
import 'external_proto_name.dart';

class EntityFieldCodeGenerator extends FieldCodeGenerator
    implements ExternalProtoName {
  EntityFieldCodeGenerator(
      FieldDescriptor fieldDescriptor, int lineNumber, String filePrefix)
      : super(fieldDescriptor, lineNumber) {
    var fieldElementType = fieldDescriptor.itemType;

    var annotation = TypeChecker.fromRuntime(ProtoBase)
        .firstAnnotationOf(fieldElementType.element!);

    var packageName =
        annotation?.getField('packageName')?.toStringValue() ?? '';

    var fieldElementTypeName =
        '${fieldDescriptor.prefix}${fieldElementType.getDisplayString(withNullability: false)}';
    _fieldType = packageName != ''
        ? '$packageName.${fieldElementTypeName}'
        : fieldElementTypeName;

    var segments = fieldElementType.element!.source!.uri.pathSegments.toList();
    var lastSrc = segments.lastIndexOf('src');
    if (lastSrc != -1) segments.removeRange(0, lastSrc + 1);
    var fileName = segments[segments.length - 1];
    fileName =
        fileName.substring(0, fileName.length - 4) + filePrefix + 'proto';
    segments[segments.length - 1] = fileName;
    _externalProtoName = segments.join('/');
  }

  String? _externalProtoName;
  String? get externalProtoName => _externalProtoName;

  String? _fieldType;
  @override
  String? get fieldType => _fieldType;
}
