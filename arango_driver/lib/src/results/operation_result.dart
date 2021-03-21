import 'package:arango_driver/src/results/identifier.dart';

import 'result.dart';

class OperationResult {
  final Map<String, dynamic> map;
  final Identifier identifier;
  final String oldRev;
  final Result result;

  const OperationResult({
    required this.map,
    required this.result,
    required this.identifier,
    this.oldRev = '',
  });
}
