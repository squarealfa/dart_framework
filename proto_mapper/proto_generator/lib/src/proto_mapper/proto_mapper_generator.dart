import 'package:build/src/builder/builder.dart';
import 'package:proto_annotations/proto_annotations.dart';
import 'package:source_gen/src/constants/reader.dart';

import 'proto_mapper_generator_base.dart';

class ProtoMapperGenerator extends ProtoMapperGeneratorBase<MapProto> {
  ProtoMapperGenerator(BuilderOptions options) : super(options);

  @override
  MapProto? hydrateAnnotation(ConstantReader reader, {String? prefix}) {
    var ret = MapProto(
      prefix: reader.read('prefix').literalValue as String? ?? prefix,
      packageName: reader.read('packageName').literalValue as String?,
    );

    return ret;
  }
}
