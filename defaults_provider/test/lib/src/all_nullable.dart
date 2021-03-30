import 'package:defaults_provider_annotations/defaults_provider_annotations.dart';

part 'all_nullable.g.dart';

@defaultsProvider
class AllNullable {
  String? prop1;
  int? prop2;

  AllNullable();
}
