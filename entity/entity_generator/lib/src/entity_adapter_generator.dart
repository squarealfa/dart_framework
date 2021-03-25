import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:entity_adapter/entity_adapter.dart';
import 'package:source_gen/source_gen.dart';

class EntityAdapterGenerator extends GeneratorForAnnotation<MapEntity> {
  ClassElement _classElement;

  EntityAdapterGenerator(BuilderOptions options);

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader reader,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) return '';
    _classElement = element as ClassElement;
    var className = _classElement.name;
    var protoClassName = 'G$className';

    if (_classElement.kind.name == 'ENUM') {
      return null;
    }

    if (!(_classElement.allSupertypes?.any((element) =>
            element.getDisplayString(withNullability: false) == 'Entity') ??
        true)) {
      return null;
    }

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
