import 'package:decimal/decimal.dart';

import '../field_code_generator.dart';
import '../field_descriptor.dart';

class SetFieldCodeGenerator extends FieldCodeGenerator {
  SetFieldCodeGenerator(FieldDescriptor fieldDescriptor)
      : super(fieldDescriptor);

  String get _valueToProto {
    final fieldTypeName = fieldDescriptor.setParameterType!
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
    return ''' const \$${fieldDescriptor.parameterTypeName}ProtoMapper().toProto(e)''';
  }

  String get _toProtoConversion {
    final setParameterType = fieldDescriptor.setParameterType!;

    if (setParameterType.isDartCoreBool ||
        setParameterType.isDartCoreDouble ||
        setParameterType.isDartCoreInt ||
        setParameterType.isDartCoreString) {
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
    final setParameterType = fieldDescriptor.setParameterType!;
    if (setParameterType.isDartCoreBool ||
        setParameterType.isDartCoreDouble ||
        setParameterType.isDartCoreInt ||
        setParameterType.isDartCoreString) {
      return 'e';
    }
    final fieldTypeName = fieldDescriptor.setParameterType!
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

    return ''' const \$${fieldDescriptor.parameterTypeName}ProtoMapper().fromProto(e)''';
  }

  @override
  String get fromProtoExpression => super.fromProtoExpression;

  @override
  String get fromProtoNonNullableExpression =>
      '''Set<${fieldDescriptor.parameterTypeName}>.unmodifiable(instance.$protoFieldName.map((e) => $_protoToValue))''';
}
