import 'package:build/src/builder/builder.dart';
import 'package:proto_annotations/proto_annotations.dart';
import 'package:proto_generator/src/proto/proto_generator_base.dart';
import 'package:source_gen/src/constants/reader.dart';

class ProtoGenerator extends ProtoGeneratorBase<Proto> {
  ProtoGenerator(BuilderOptions options) : super(options);

  @override
  Proto hydrateAnnotation(ConstantReader reader, {String prefix = ''}) {
    var ret = Proto(
      prefix: reader.read('prefix').literalValue as String? ?? prefix,
      includeFieldsByDefault:
          reader.read('includeFieldsByDefault').literalValue as bool,
      packageName: reader.read('packageName').literalValue as String? ?? '',
    );

    return ret;
  }
}
