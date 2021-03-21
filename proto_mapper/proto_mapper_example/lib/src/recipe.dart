import 'package:proto_annotations/proto_annotations.dart';

import 'ingredient.dart';



@proto // generate .proto message based on this .dart file
// generate mapping code between the protoc generated code and this class.
@mapProto
class Recipe {
  final String key;

  // generate the field on the .proto message with the name 'ptitle'
  // the mapping code is also adapted to the name 'ptitle'
  @ProtoField(name: 'ptitle')
  final String title;

  // by default all public non-static properties are generated
  // so, this list is also generated. Take care to decorate the
  // [Ingredient] class with @proto and @mapProto
  final List<Ingredient> ingredients;

  // do not generate the field in the .proto message nor
  // generate mapping code for it.
  @protoIgnore
  final String? runtimeTag;

  Recipe(
      {this.key = '',
      required this.title,
      required this.ingredients,
      this.runtimeTag});
}
