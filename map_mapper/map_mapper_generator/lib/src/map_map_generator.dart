import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:map_mapper_annotations/map_mapper_annotations.dart';

import 'package:source_gen/source_gen.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';

import 'field_code_generator.dart';
import 'field_descriptor.dart';

class MapMapGenerator extends GeneratorForAnnotation<MapMap> {
  ClassElement? _classElement;
  String? _className;

  @override
  String? generateForAnnotatedElement(
    Element element,
    ConstantReader reader,
    BuildStep buildStep,
  ) {
    final annotation = _hydrateAnnotation(reader);

    if (element is! ClassElement) return null;
    _classElement = element;
    _className = element.name;

    if (_classElement!.kind.name == 'ENUM') {
      return renderEnumMapper();
    }

    var toMapFieldBuffer = StringBuffer();
    var fromMapFieldBuffer = StringBuffer();
    var constructorFieldBuffer = StringBuffer();

    var fieldDescriptors = _getFieldDescriptors(_classElement!, annotation);
    var defaultsProviderClassName =
        getDefaultsProvider(_classElement, annotation, fieldDescriptors);
    var hasDefaultsProvider = defaultsProviderClassName != null;

    for (var fieldDescriptor in fieldDescriptors) {
      var fieldCodeGenerator = FieldCodeGenerator.fromFieldDescriptor(
          fieldDescriptor, hasDefaultsProvider);

      var toMapMap = fieldCodeGenerator.toMapMap;
      toMapFieldBuffer.writeln(toMapMap);

      if (fieldDescriptor.fieldElement.isFinal) {
        var constructorMap = fieldCodeGenerator.constructorMap;
        constructorFieldBuffer.writeln(constructorMap);
      } else {
        var fromMapMap = fieldCodeGenerator.fromMapMap;
        fromMapFieldBuffer.writeln(fromMapMap);
      }
    }

    var ret = renderMapper(
      defaultsProviderClassName,
      toMapFieldBuffer,
      fromMapFieldBuffer,
      constructorFieldBuffer,
    );

    return ret;
  }

  String renderMapper(
    String? defaultsProviderClassName,
    StringBuffer toMapFieldBuffer,
    StringBuffer fromMapFieldBuffer,
    StringBuffer constructorFieldBuffer,
  ) {
    var className = _className;
    var defaultsProviderDeclaration = ((defaultsProviderClassName ?? '') == '')
        ? ''
        : 'var defaultsProvider = $defaultsProviderClassName();';
    return '''

      class ${className}MapMapper extends MapMapper<$className> {
        static final ${className}MapMapper _singleton = ${className}MapMapper._();

        ${className}MapMapper._();
        factory ${className}MapMapper() => _singleton;


        @override
        $className fromMap(Map<String, dynamic> map) { 
        
          $defaultsProviderDeclaration
          
          return $className($constructorFieldBuffer)
              $fromMapFieldBuffer; 
        }

        @override
        Map<String, dynamic> toMap($className instance) {
            final map = <String, dynamic>{};
        
            $toMapFieldBuffer  
              
            return map;
        }
      }


      extension ${className}MapExtension on $className {
        Map<String, dynamic> toMap() => ${className}MapMapper().toMap(this);
        static $className fromMap(Map<String, dynamic> map) => ${className}MapMapper().fromMap(map);
      }
      
      extension Map${className}Extension on Map<String, dynamic> {
        $className to$className() => ${className}MapMapper().fromMap(this);
      }

  
  ''';
  }

  String renderEnumMapper() {
    var className = _className;
    return '''
    class ${className}MapMapper
    {
      $className fromMap(dynamic e) => $className.values[e];
      dynamic toMap($className e) => e.index;
      
      static final ${className}MapMapper singleton = ${className}MapMapper();
    }
    ''';
  }

  static String? getDefaultsProvider(
    ClassElement? classElement,
    MapMap annotation,
    Iterable<FieldDescriptor> fieldDescriptors,
  ) {
    if (annotation.useDefaultsProvider == false) {
      return null;
    }
    if (!fieldDescriptors.any((element) => !element.isNullable)) {
      return null;
    }
    return '${classElement!.name}DefaultsProvider';
  }
}

Iterable<FieldDescriptor> _getFieldDescriptors(
    ClassElement classElement, MapMap annotation) {
  final fieldSet = classElement.getSortedFieldSet();
  final fieldDescriptors = fieldSet
      .map((fieldElement) => FieldDescriptor.fromFieldElement(
            classElement,
            fieldElement!,
            annotation,
          ))
      .where((element) => element.isMapIncluded);
  return fieldDescriptors;
}

MapMap _hydrateAnnotation(ConstantReader reader) {
  var ret = MapMap(
    includeFieldsByDefault:
        reader.read('includeFieldsByDefault').literalValue as bool,
    useDefaultsProvider:
        reader.read('useDefaultsProvider').literalValue as bool,
  );
  return ret;
}
