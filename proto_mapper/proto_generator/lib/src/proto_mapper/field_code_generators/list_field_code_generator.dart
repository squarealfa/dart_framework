import 'package:decimal/decimal.dart';

import '../field_code_generator.dart';
import '../field_descriptor.dart';

class ListFieldCodeGenerator extends FieldCodeGenerator {
  ListFieldCodeGenerator(FieldDescriptor fieldDescriptor)
      : super(fieldDescriptor);

  String get _valueToProto {
    final fieldTypeName = fieldDescriptor.listParameterType!
        .getDisplayString(withNullability: false);
    if (fieldTypeName == (Decimal).toString()) {
      return 'e.toString()';
    }
    if (fieldTypeName == (DateTime).toString()) {
      return 'Int64(e.millisecondsSinceEpoch)';
    }
    if (fieldTypeName == (Duration).toString()) {
      return 'e.inMilliseconds.toDouble()';
    }
    return ''' const ${fieldDescriptor.parameterTypeName}ProtoMapper().toProto(e)''';
  }

  String get _toProtoConversion {
    final listParameterType = fieldDescriptor.listParameterType!;

    if (listParameterType.isDartCoreBool ||
        listParameterType.isDartCoreDouble ||
        listParameterType.isDartCoreInt ||
        listParameterType.isDartCoreString) {
      return '';
    }
    return '.map((e) => $_valueToProto)';
  }

  @override
  String get toProtoMap => fieldDescriptor.isNullable
      ? '''        
      proto.$protoFieldName
        .addAll(instance.$fieldName${_toProtoConversion != '' ? '?' : ''}$_toProtoConversion ?? []);
        $hasValueToProtoMap;
      '''
      : '''
        proto.$protoFieldName
          .addAll(instance.$fieldName$_toProtoConversion);

      ''';

  String get _protoToValue {
    final listParameterType = fieldDescriptor.listParameterType!;
    if (listParameterType.isDartCoreBool ||
        listParameterType.isDartCoreDouble ||
        listParameterType.isDartCoreInt ||
        listParameterType.isDartCoreString) {
      return 'e';
    }
    final fieldTypeName = fieldDescriptor.listParameterType!
        .getDisplayString(withNullability: false);
    if (fieldTypeName == (Decimal).toString()) {
      return 'Decimal.parse(e)';
    }
    if (fieldTypeName == (DateTime).toString()) {
      return 'DateTime.fromMillisecondsSinceEpoch(e.toInt())';
    }
    if (fieldTypeName == (Duration).toString()) {
      return 'Duration(milliseconds: e.toInt())';
    }

    return ''' const ${fieldDescriptor.parameterTypeName}ProtoMapper().fromProto(e)''';
  }

  @override
  String get fromProtoExpression => super.fromProtoExpression;

  @override
  String get fromProtoNonNullableExpression =>
      'instance.$protoFieldName.map((e) => $_protoToValue).toList()';
}
