/// When applied as an annotation to a field, indicates the code
/// generator to map that field.
///
/// This annotation can be particularly useful to
/// map fields that should have a different name when
/// mapped to the Map<String, dynamic>.
class MapField {
  final String? name;
  const MapField({this.name});
}
