import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:proto_annotations/proto_annotations.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';

import 'field_code_generator.dart';
import 'field_descriptor.dart';

part 'proto_mapper_generator.helpers.dart';

class ProtoMapperGenerator extends GeneratorForAnnotation<MapProto> {
  final BuilderOptions options;
  String? _prefix;

  ClassElement? _classElement;
  ClassElement? get classElement => _classElement;
  String? get className => _classElement?.name;

  String? get prefix => _prefix;

  ProtoMapperGenerator(this.options) {
    var config = options.config;
    _prefix = config['prefix'] as String? ?? 'G';
  }

  // TProtoMapperAnnotation? hydrateAnnotation(ConstantReader constantReader,
  //     {String? prefix});

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader constantReader,
    BuildStep buildStep,
  ) {
    var annotation = _hydrateAnnotation(constantReader, prefix: _prefix);
    if (annotation == null) return '';
    _prefix = annotation.prefix ?? _prefix;

    _classElement = element.asClassElement();
    if (_classElement!.kind.name == 'ENUM') return renderEnumMapper();

    final fieldDescriptors = _getFieldDescriptors(_classElement!, annotation);

    var toProtoFieldBuffer = StringBuffer();
    var fromProtoFieldBuffer = StringBuffer();
    var constructorFieldBuffer = StringBuffer();

    for (var fieldDescriptor in fieldDescriptors) {
      var fieldCodeGenerator =
          FieldCodeGenerator.fromFieldDescriptor(fieldDescriptor);

      toProtoFieldBuffer.writeln(fieldCodeGenerator.toProtoMap);

      if (fieldDescriptor.fieldElement.isFinal) {
        var constructorMap = fieldCodeGenerator.constructorMap;
        constructorFieldBuffer.writeln(constructorMap);
      } else {
        var fromProtoMap = fieldCodeGenerator.fromProtoMap;
        fromProtoFieldBuffer.writeln('  ..$fromProtoMap');
      }
    }

    var renderBuffer = StringBuffer();
    var mapper = renderMapper(
      toProtoFieldBuffer,
      fromProtoFieldBuffer,
      constructorFieldBuffer,
    );

    renderBuffer.writeln(mapper);

    return renderBuffer.toString();
  }

  String renderMapper(
    StringBuffer toProtoFieldBuffer,
    StringBuffer fromProtoFieldBuffer,
    StringBuffer constructorFieldBuffer,
  ) {
    var prefix = _prefix;

    return '''
  
      class ${className}ProtoMapper implements ProtoMapper<$className, $prefix$className> {
        const ${className}ProtoMapper();

        @override
        $className fromProto($prefix$className proto) => _\$${className}FromProto(proto);
  
        @override
        $prefix$className toProto($className entity) => _\$${className}ToProto(entity);
        
        $className fromJson(String json) =>
          _\$${className}FromProto($prefix$className.fromJson(json));
        String toJson($className entity) => _\$${className}ToProto(entity).writeToJson();

        String toBase64Proto($className entity) =>
          base64Encode(utf8.encode(entity.toProto().writeToJson()));

        $className fromBase64Proto(String base64Proto) =>
            $prefix$className.fromJson(utf8.decode(base64Decode(base64Proto)))
                .to$className();
      }
      
            

      $prefix$className _\$${className}ToProto($className instance) 
      {
        var proto = $prefix$className();
        
        $toProtoFieldBuffer
        
        return proto;
      }

      $className _\$${className}FromProto($prefix$className instance) =>
        $className($constructorFieldBuffer)
          $fromProtoFieldBuffer;  

      extension ${className}ProtoExtension on $className {
        $prefix$className toProto() => _\$${className}ToProto(this);
        String toJson() => _\$${className}ToProto(this).writeToJson();
      
        static $className fromProto($prefix$className proto) => _\$${className}FromProto(proto);
        static $className fromJson(String json) => _\$${className}FromProto($prefix$className.fromJson(json));
      }
      
      
      extension $prefix${className}ProtoExtension on $prefix$className {
        $className to$className() => _\$${className}FromProto(this);
      }
     

  ''';
  }

  String renderEnumMapper() {
    return '''
      class ${className}ProtoMapper implements ProtoMapper<$className, $prefix$className> {
        const ${className}ProtoMapper();

        @override
        $className fromProto($prefix$className proto) => 
          $className.values[proto.value];
        
          
        @override
        $prefix$className toProto($className entity) => 
          $prefix$className.valueOf(entity.index)!;
      }    
  ''';
  }
}

MapProto? _hydrateAnnotation(ConstantReader reader, {String? prefix}) {
  var ret = MapProto(
    prefix: reader.read('prefix').literalValue as String? ?? prefix,
    packageName: reader.read('packageName').literalValue as String,
  );

  return ret;
}
