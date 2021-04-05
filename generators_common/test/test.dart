import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build_resolvers/build_resolvers.dart';
import 'package:build_test/build_test.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';
import 'package:test/test.dart';

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
}

abstract class RecipeServices extends CrudServices<Recipe> {
  final String instanceProp = '';
  static String staticProp = '';

  Future<List<Recipe>> search(SearchCriteria criteria);
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

void main() {
  group('ClassElementExtensions', () {
    // test('Non-Inherited methods', () {
    //   return testClass(_recipeServicesCode, (classElement) {
    //     final methods = classElement.getSortedMethods(includeInherited: false);
    //     expect(methods.length, 1);
    //   });
    // });

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
