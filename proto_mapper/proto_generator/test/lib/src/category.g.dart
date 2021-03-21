// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// ProtoMapperGenerator
// **************************************************************************

class CategoryProtoMapper implements ProtoMapper<Category, GCategory> {
  static final CategoryProtoMapper _singleton = CategoryProtoMapper._();

  CategoryProtoMapper._();
  factory CategoryProtoMapper() => _singleton;

  @override
  Category fromProto(GCategory proto) => _$CategoryFromProto(proto);

  @override
  GCategory toProto(Category entity) => _$CategoryToProto(entity);

  Category fromJson(String json) =>
      _$CategoryFromProto(GCategory.fromJson(json));
  String toJson(Category entity) => _$CategoryToProto(entity).writeToJson();
}

GCategory _$CategoryToProto(Category instance) {
  var proto = GCategory();

  proto.title = instance.title;
  proto.mainComponent = ComponentProtoMapper().toProto(instance.mainComponent);
  if (instance.alternativeComponent != null) {
    proto.alternativeComponent =
        ComponentProtoMapper().toProto(instance.alternativeComponent!);
  }
  proto.alternativeComponentHasValue = instance.alternativeComponent != null;

  proto.otherComponents.addAll(
      instance.otherComponents.map((e) => ComponentProtoMapper().toProto(e)));

  proto.secondaryComponents.addAll(instance.secondaryComponents
          ?.map((e) => ComponentProtoMapper().toProto(e)) ??
      []);
  proto.secondaryComponentsHasValue = instance.secondaryComponents != null;

  return proto;
}

Category _$CategoryFromProto(GCategory instance) => Category(
      title: instance.title,
      mainComponent: ComponentProtoMapper().fromProto(instance.mainComponent),
      alternativeComponent: (instance.alternativeComponentHasValue
          ? (ComponentProtoMapper().fromProto(instance.alternativeComponent))
          : null),
      otherComponents: instance.otherComponents
          .map((e) => ComponentProtoMapper().fromProto(e))
          .toList(),
      secondaryComponents: (instance.secondaryComponentsHasValue
          ? (instance.secondaryComponents
              .map((e) => ComponentProtoMapper().fromProto(e))
              .toList())
          : null),
    );

extension CategoryProtoExtension on Category {
  GCategory toProto() => _$CategoryToProto(this);
  String toJson() => _$CategoryToProto(this).writeToJson();

  static Category fromProto(GCategory proto) => _$CategoryFromProto(proto);
  static Category fromJson(String json) =>
      _$CategoryFromProto(GCategory.fromJson(json));
}

extension GCategoryProtoExtension on GCategory {
  Category toCategory() => _$CategoryFromProto(this);
}
