import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:squarealfa_entity_adapter/squarealfa_entity_adapter.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';

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
    var protoClassName = 'G$className';

    var ret = '''


class ${className}Permissions extends EntityPermissions {
  static final ${className}Permissions _singleton = ${className}Permissions._();

  ${className}Permissions._();

  factory ${className}Permissions() => _singleton;

  @override
  String get create => 'create$className';

  @override
  String get delete => 'delete$className';

  @override
  String get read => 'read$className';

  @override
  String get update => 'update$className';
}


class ${className}EntityAdapter implements EntityAdapter<$className, $protoClassName> {
  @override
  final MapMapper<$className> mapMapper = ${className}MapMapper();

  @override
  final ProtoMapper<$className, $protoClassName> protoMapper = ${className}ProtoMapper();

  @override
  final Validator validator = ${className}Validator();

  @override
  final EntityPermissions permissions = ${className}Permissions();
}


   
    ''';
    return ret;
  }
}
