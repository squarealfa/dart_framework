import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:squarealfa_entity_adapter/squarealfa_entity_adapter.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';

/// Generates EntityAdapter and EntityPermissions classes for PODOs
///
/// Check the README.md for an overview.
class EntityAdapterGenerator extends GeneratorForAnnotation<EntityAdapted> {
  EntityAdapterGenerator(BuilderOptions options);

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader reader,
    BuildStep buildStep,
  ) {
    var classElement = element.asClassElement();

    if (classElement.kind.name == 'ENUM') return '';

    var type = reader.read('rootEntityType').typeValue;
    if (!classElement.allSupertypes.any((st) => st.element == type.element)) {
      return '';
    }

    var className = classElement.name;

    var ret = '''


class ${className}Permissions extends EntityPermissions {

  const ${className}Permissions();

  @override
  String get create => 'create$className';

  @override
  String get delete => 'delete$className';

  @override
  String get read => 'read$className';

  @override
  String get update => 'update$className';
}


class ${className}EntityAdapter implements EntityAdapter<$className> {
  @override
  final MapMapper<$className> mapMapper = const ${className}MapMapper();

  @override
  final Validator validator = const ${className}Validator();

  @override
  final EntityPermissions permissions = const ${className}Permissions();
}


   
    ''';
    return ret;
  }
}
