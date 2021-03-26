import 'package:tuple/tuple.dart';

import '../field_descriptor.dart';

abstract class PropertyValidator {
  Tuple2<String, bool> createValidatorCode(
    FieldDescriptor fieldDescriptor,
    bool previousNullCheck,
  );
}

Tuple2<String, bool> createResult([
  String code = '',
  bool didFinalNullCheck = false,
]) =>
    Tuple2<String, bool>(
      code,
      didFinalNullCheck,
    );
