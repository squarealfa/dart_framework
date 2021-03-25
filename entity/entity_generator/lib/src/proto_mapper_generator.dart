import 'package:build/src/builder/builder.dart';
import 'package:source_gen/source_gen.dart';
import 'package:entity_adapter/entity_adapter.dart';
import 'package:proto_generator/proto_generator.dart';

class ProtoMapperGenerator extends ProtoMapperGeneratorBase<MapEntity> {
  ProtoMapperGenerator(BuilderOptions options) : super(options);

  @override
  MapEntity hydrateAnnotation(ConstantReader reader, {String prefix}) {
    var ret = MapEntity(
      generateProtoMapper:
          reader.read('generateProtoMapper').literalValue as bool ?? true,
      prefix: reader.read('prefix').literalValue as String ?? prefix,
      includeFieldsByDefault:
          reader.read('includeFieldsByDefault').literalValue as bool,
      nullableFieldsByDefault:
          reader.read('nullableFieldsByDefault').literalValue as bool,
      emptyNotNullFieldsByDefault:
          reader.read('emptyNotNullFieldsByDefault').literalValue as bool,
      packageName: reader.read('packageName').literalValue as String,
    );


    return ret.generateProtoMapper ? ret : null;
  }

  
}
