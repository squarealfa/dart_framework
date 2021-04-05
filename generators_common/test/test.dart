import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build_resolvers/build_resolvers.dart';
import 'package:build_test/build_test.dart';
import 'package:squarealfa_generators_common/squarealfa_generators_common.dart';
import 'package:test/test.dart';

const _recipeServicesCode = '''

    abstract class RecipeServices {
      void sayHello();
    }
''';

const _recipeCode = '''

class Entity {
  final String id;
  String _key = '';

  String get rprop => '';

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

  Recipe({
    required String id,
    this.description = '',
    required this.title,
  }) : super(id);
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
      return testClass(_recipeCode, 'Recipe', (classElement) {
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
      });
    });

    test('Including inherited fields', () {
      return testClass(_recipeCode, 'Recipe', (classElement) {
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
      });
    });
  });
}
