This package includes code generators that augment classes that are meant to be used as business entities. More concretely, the generated classes add the following features to otherwise barebones PODO - Plain Old Dart Object - classes:

- Business rules validation
- Extension to add copyWith method
- Builder class


## Getting Started 

### Validations


Start by adding the ```@validatable```annotation to the [PODO](https://github.com/squarealfa/dart_framework/#podos) class for which you want validation code to be generated:

```dart
/// ensure the library has the part statement.
part 'recipe.g.dart';

@validatable
class Recipe {

    final String title;

    const Recipe({required this.title});
}

```

This will generate a ```Validator``` class that will contain a validation method for each of the properties of the [PODO](https://github.com/squarealfa/dart_framework/#podos) class. By default each validation method will return null, as examplified:

```dart
/// This is an example of a generated validator class.
class RecipeValidator implements Validator {
  const RecipeValidator();

  ValidationError? validateTitle(String value) {
    return null;
  }

  @override
  ErrorList validate(covariant Recipe entity) {
    var errors = <ValidationError>[];
    ValidationError? error;
    if ((error = validateTitle(entity.title)) != null) {
      errors.add(error!);
    }

    return ErrorList(errors);
  }

  @override
  void validateThrowing(covariant Recipe entity) {
    var errors = validate(entity);
    if (errors.validationErrors.isNotEmpty) throw errors;
  }

```

Annotate each field with a rule that you want to apply to that field:

```dart
/// ensure the library has the part statement.
part 'ingredient.g.dart';

@validatable
class Ingredient {

  @StringLength(minLength: 10)
  final String description;

  @StringLength(maxLength: 10)
  final String? notes;

  @StringLength(minLength: 2)
  final String? tag;

  @DoubleRange(minValue: 10, maxValue: 20)
  final double quantity;

  @Range(minValue: 10)
  final Decimal precision;

  @Range(minValue: 10, maxValue: 20)
  final int intQuantity;

  @Range(minValue: 10, maxValue: 20)
  final int? nintQuantity;

  @Range(minValue: 10, maxValue: 20)
  @required
  final int? rInt;

  Ingredient({
    required this.description,
    required this.quantity,
    required this.precision,
    required this.intQuantity,
    this.notes,
    this.tag,
    this.nintQuantity,
    this.rInt,
  });
}

```

### Builder

Add a ```@builder``` annotation to the [PODO](https://github.com/squarealfa/dart_framework/#podos):

```dart
/// ensure the library has the part statement.
part 'recipe.g.dart';

@builder
class Recipe {
  final String title;

  final String? description;
  
  Recipe({
    required this.title,
    this.description,
  });
}
```

This will generate a non-immutable builder class:

```dart
class RecipeBuilder implements Builder<Recipe> {
  String title;
  String? description;

  RecipeBuilder({
    required this.title,
    this.description,
  });

  factory RecipeBuilder.fromRecipe(Recipe entity) {
    return RecipeBuilder(
      title: entity.title,
      description: entity.description,
    );
  }

  @override
  Recipe build() {
    var entity = Recipe(
      title: title,
      description: description,
    );
    RecipeValidator().validateThrowing(entity);
    return entity;
  }
}

```

### copyWith

Add a ```@builder``` annotation to the [PODO](https://github.com/squarealfa/dart_framework/#podos):

```dart
/// ensure the library has the part statement.
part 'recipe.g.dart';

@copyWith
class Recipe {
  final String title;

  final String? description;
  
  Recipe({
    required this.title,
    this.description,
  });
}
```

This will generate an extension to the [PODO](https://github.com/squarealfa/dart_framework/#podos) that adds the ```copyWith``` method:

```dart
extension RecipeCopyWithExtension on Recipe {
  Recipe copyWith({
    String? title,
    String? description,
    bool setDescriptionToNull = false,
  }) {
    return Recipe(
      title: title ?? this.title,
      description:
          setDescriptionToNull ? null : description ?? this.description,
    );
  }
}
```


## Context

This package is part of a set of losely integrated packages that constitute the [SquareAlfa Dart Framework](https://github.com/squarealfa/dart_framework#squarealfa-dart-framework).
