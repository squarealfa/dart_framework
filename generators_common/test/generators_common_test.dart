import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build_resolvers/build_resolvers.dart';
import 'package:build_test/build_test.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';
import 'package:test/test.dart';

void main() {
  group('ClassElementExtensions', () {
    test('Without inherited methods', () {
      return testClass(_code, 'RecipeServices', (classElement) {
        final methods = classElement.getSortedMethods(includeInherited: false);
        expect(methods.any((f) => f.name == 'search'), true);
        expect(methods.any((f) => f.name == 'create'), false);
        expect(methods.any((f) => f.name == 'update'), false);
        expect(methods.any((f) => f.name == 'delete'), false);

        expect(methods.any((f) => f.name == 'staticProp'), false);
        expect(methods.any((f) => f.name == 'instanceProp'), false);
        expect(methods.any((f) => f.name == 'staticMethod'), false);

        expect(methods.any((f) => f.name == 'superInstanceProp'), false);
        expect(methods.any((f) => f.name == 'superStaticProp'), false);
        expect(methods.any((f) => f.name == 'superStaticMethod'), false);
      });
    });

    test('create method result', () {
      return testClass(_code, 'RecipeServices', (classElement) {
        final methods = classElement.getSortedMethods(includeInherited: true);
        final createMethod = methods.where((m) => m.name == 'create').first;
        final displayString = createMethod.returnType.finalType
            .getDisplayString(withNullability: false);
        final isList = createMethod.returnType.isList;
        expect(displayString, 'Recipe');
        expect(isList, false);
      });
    });

    test('create method parameter', () {
      return testClass(_code, 'RecipeServices', (classElement) {
        final methods = classElement.getSortedMethods(includeInherited: true);
        final createMethod = methods.where((m) => m.name == 'create').first;
        final parmType = createMethod.parameters.first.type;
        final displayString = parmType.getDisplayString(withNullability: false);
        final isList = parmType.isList;
        expect(displayString, 'Recipe');
        expect(isList, false);
      });
    });

    test('update method result', () {
      return testClass(_code, 'RecipeServices', (classElement) {
        final methods = classElement.getSortedMethods(includeInherited: true);
        final createMethod = methods.where((m) => m.name == 'update').first;
        final displayString = createMethod.returnType.finalType
            .getDisplayString(withNullability: false);
        final isList = createMethod.returnType.isList;
        expect(displayString, 'Recipe');
        expect(isList, false);
      });
    });

    test('update method parameter', () {
      return testClass(_code, 'RecipeServices', (classElement) {
        final methods = classElement.getSortedMethods(includeInherited: true);
        final createMethod = methods.where((m) => m.name == 'update').first;
        final parmType = createMethod.parameters.first.type;
        final displayString = parmType.getDisplayString(withNullability: false);
        final isList = parmType.isList;
        expect(displayString, 'Recipe');
        expect(isList, false);
      });
    });

    test('delete method result', () {
      return testClass(_code, 'RecipeServices', (classElement) {
        final methods = classElement.getSortedMethods(includeInherited: true);
        final createMethod = methods.where((m) => m.name == 'delete').first;
        final displayString = createMethod.returnType.finalType
            .getDisplayString(withNullability: false);
        final isList = createMethod.returnType.isList;
        expect(displayString, 'Recipe');
        expect(isList, false);
      });
    });

    test('delete method parameter', () {
      return testClass(_code, 'RecipeServices', (classElement) {
        final methods = classElement.getSortedMethods(includeInherited: true);
        final createMethod = methods.where((m) => m.name == 'delete').first;
        final parmType = createMethod.parameters.first.type;
        final displayString = parmType.getDisplayString(withNullability: false);
        final isList = parmType.isList;
        expect(displayString, 'Key');
        expect(isList, false);
      });
    });

    test('search method result', () {
      return testClass(_code, 'RecipeServices', (classElement) {
        final methods = classElement.getSortedMethods(includeInherited: true);
        final createMethod = methods.where((m) => m.name == 'search').first;
        final returnType = createMethod.returnType;
        final displayString =
            returnType.finalType.getDisplayString(withNullability: false);
        final isList = returnType.isList;
        expect(displayString, 'Recipe');
        expect(isList, true);
      });
    });

    test('search method parameter', () {
      return testClass(_code, 'RecipeServices', (classElement) {
        final methods = classElement.getSortedMethods(includeInherited: true);
        final createMethod = methods.where((m) => m.name == 'search').first;
        final parmType = createMethod.parameters.first.type;
        final displayString =
            parmType.finalType.getDisplayString(withNullability: false);
        final isList = parmType.isList;
        expect(displayString, 'SearchCriteria');
        expect(isList, false);
      });
    });

    test('With inherited methods', () {
      return testClass(_code, 'RecipeServices', (classElement) {
        final methods = classElement.getSortedMethods(
          includeInherited: true,
        );
        expect(methods.any((f) => f.name == 'search'), true);
        expect(methods.any((f) => f.name == 'create'), true);
        expect(methods.any((f) => f.name == 'update'), true);
        expect(methods.any((f) => f.name == 'delete'), true);

        expect(methods.any((f) => f.name == 'staticProp'), false);
        expect(methods.any((f) => f.name == 'instanceProp'), false);
        expect(methods.any((f) => f.name == 'staticMethod'), false);

        expect(methods.any((f) => f.name == 'superInstanceProp'), false);
        expect(methods.any((f) => f.name == 'superStaticProp'), false);
        expect(methods.any((f) => f.name == 'superStaticMethod'), false);
      });
    });

    test('Without inherited fields', () {
      return testClass(_code, 'Recipe', (classElement) {
        final fields = classElement.getSortedFieldSet(includeInherited: false);
        expect(fields.any((f) => f.name == 'title'), true);
        expect(fields.any((f) => f.name == 'description'), true);
        expect(fields.any((f) => f.name == 'tag'), true);

        expect(fields.any((f) => f.name == '_tag'), false);
        expect(fields.any((f) => f.name == 'duration'), false);

        expect(fields.any((f) => f.name == 'id'), false);
        expect(fields.any((f) => f.name == '_key'), false);
        expect(fields.any((f) => f.name == 'rprop'), false);
        expect(fields.any((f) => f.name == 'key'), false);

        expect(fields.any((f) => f.name == 'staticProp'), false);
        expect(fields.any((f) => f.name == 'constProp'), false);
        expect(fields.any((f) => f.name == 'superStaticProp'), false);
        expect(fields.any((f) => f.name == 'superSonstProp'), false);
      });
    });

    test('Including inherited fields', () {
      return testClass(_code, 'Recipe', (classElement) {
        final fields = classElement.getSortedFieldSet(includeInherited: true);
        expect(fields.any((f) => f.name == 'title'), true);
        expect(fields.any((f) => f.name == 'description'), true);
        expect(fields.any((f) => f.name == 'tag'), true);

        expect(fields.any((f) => f.name == '_tag'), false);
        expect(fields.any((f) => f.name == 'duration'), false);

        expect(fields.any((f) => f.name == 'id'), true);
        expect(fields.any((f) => f.name == 'key'), true);

        expect(fields.any((f) => f.name == '_key'), false);
        expect(fields.any((f) => f.name == 'rprop'), false);

        expect(fields.any((f) => f.name == 'staticProp'), false);
        expect(fields.any((f) => f.name == 'constProp'), false);
        expect(fields.any((f) => f.name == 'superStaticProp'), false);
        expect(fields.any((f) => f.name == 'superSonstProp'), false);
      });
    });
  });
}

const _code = '''

class Entity {
  final String id;
  String _key = '';

  String get rprop => '';

  static String superStaticProp = '';
  static const String superConstProp = '';

  String get key => _key;
  set key(String value) {
    if (value == 'invalid') throw Error();
    _key = value;
  }

  Entity(this.id);
}

class Recipe extends Entity {
  final String title;
  String description;
  int get duration => 30;

  String _tag = '';
  String get tag => _tag;
  set tag(String value) {
    if (value == 'invalid') throw Error();
    _tag = value;
  }

  static String staticProp = '';
  static const String constProp = '';

  Recipe({
    required String id,
    this.description = '',
    required this.title,
  }) : super(id);
}

class Key {
  final String key;

  Key(this.key);
}

class SearchCriteria {
  final String title;

  SearchCriteria(this.title);
}

abstract class CrudServices<TEntity> {
  final String superInstanceProp = '';
  static String superStaticProp = '';

  TEntity create(TEntity entity);
  Future<TEntity> update(TEntity entity);
  TEntity delete(Key key);

  Future<List<TEntity>> searchAll();

  static void superStaticMethod() {}
}

abstract class RecipeServices extends CrudServices<Recipe> {
  final String instanceProp = '';
  static String staticProp = '';

  Future<List<Recipe>> search(SearchCriteria criteria);

  static void staticMethod() {}
}
''';

Future testClass(
    String code, String className, void Function(ClassElement) tester) async {
  final entryPoint = AssetId('a', 'lib/main.dart');
  return await resolveSources({
    'a|lib/main.dart': code,
  }, (resolver) async {
    var lib = await resolver.libraryFor(entryPoint);
    final classElement = lib.topLevelElements
        .where((tl) => tl.name == className)
        .first as ClassElement;
    tester(classElement);
  }, resolvers: AnalyzerResolvers());
}
