///
//  Generated code. Do not modify.
//  source: recipe.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'category.pb.dart' as $7;
import 'ingredient.pb.dart' as $8;

import 'appliance_type.pbenum.dart' as $6;

class GRecipe extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GRecipe', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'descriptionHasValue', protoName: 'descriptionHasValue')
    ..aOM<$7.GCategory>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', subBuilder: $7.GCategory.create)
    ..pc<$8.GIngredient>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ingredients', $pb.PbFieldType.PM, subBuilder: $8.GIngredient.create)
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'publishDate', protoName: 'publishDate')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiryDate', protoName: 'expiryDate')
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiryDateHasValue', protoName: 'expiryDateHasValue')
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preparationDuration', $pb.PbFieldType.OD, protoName: 'preparationDuration')
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalDuration', $pb.PbFieldType.OD, protoName: 'totalDuration')
    ..aOB(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalDurationHasValue', protoName: 'totalDurationHasValue')
    ..aOB(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isPublished', protoName: 'isPublished')
    ..aOB(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requiresRobot', protoName: 'requiresRobot')
    ..aOB(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requiresRobotHasValue', protoName: 'requiresRobotHasValue')
    ..e<$6.GApplianceType>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mainApplianceType', $pb.PbFieldType.OE, protoName: 'mainApplianceType', defaultOrMaker: $6.GApplianceType.Heat, valueOf: $6.GApplianceType.valueOf, enumValues: $6.GApplianceType.values)
    ..e<$6.GApplianceType>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'secondaryApplianceType', $pb.PbFieldType.OE, protoName: 'secondaryApplianceType', defaultOrMaker: $6.GApplianceType.Heat, valueOf: $6.GApplianceType.valueOf, enumValues: $6.GApplianceType.values)
    ..aOB(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'secondaryApplianceTypeHasValue', protoName: 'secondaryApplianceTypeHasValue')
    ..pPS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags')
    ..pPS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'extraTags', protoName: 'extraTags')
    ..aOB(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'extraTagsHasValue', protoName: 'extraTagsHasValue')
    ..hasRequiredFields = false
  ;

  GRecipe._() : super();
  factory GRecipe({
    $core.String? title,
    $core.String? description,
    $core.bool? descriptionHasValue,
    $7.GCategory? category,
    $core.Iterable<$8.GIngredient>? ingredients,
    $fixnum.Int64? publishDate,
    $fixnum.Int64? expiryDate,
    $core.bool? expiryDateHasValue,
    $core.double? preparationDuration,
    $core.double? totalDuration,
    $core.bool? totalDurationHasValue,
    $core.bool? isPublished,
    $core.bool? requiresRobot,
    $core.bool? requiresRobotHasValue,
    $6.GApplianceType? mainApplianceType,
    $6.GApplianceType? secondaryApplianceType,
    $core.bool? secondaryApplianceTypeHasValue,
    $core.Iterable<$core.String>? tags,
    $core.Iterable<$core.String>? extraTags,
    $core.bool? extraTagsHasValue,
  }) {
    final _result = create();
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (descriptionHasValue != null) {
      _result.descriptionHasValue = descriptionHasValue;
    }
    if (category != null) {
      _result.category = category;
    }
    if (ingredients != null) {
      _result.ingredients.addAll(ingredients);
    }
    if (publishDate != null) {
      _result.publishDate = publishDate;
    }
    if (expiryDate != null) {
      _result.expiryDate = expiryDate;
    }
    if (expiryDateHasValue != null) {
      _result.expiryDateHasValue = expiryDateHasValue;
    }
    if (preparationDuration != null) {
      _result.preparationDuration = preparationDuration;
    }
    if (totalDuration != null) {
      _result.totalDuration = totalDuration;
    }
    if (totalDurationHasValue != null) {
      _result.totalDurationHasValue = totalDurationHasValue;
    }
    if (isPublished != null) {
      _result.isPublished = isPublished;
    }
    if (requiresRobot != null) {
      _result.requiresRobot = requiresRobot;
    }
    if (requiresRobotHasValue != null) {
      _result.requiresRobotHasValue = requiresRobotHasValue;
    }
    if (mainApplianceType != null) {
      _result.mainApplianceType = mainApplianceType;
    }
    if (secondaryApplianceType != null) {
      _result.secondaryApplianceType = secondaryApplianceType;
    }
    if (secondaryApplianceTypeHasValue != null) {
      _result.secondaryApplianceTypeHasValue = secondaryApplianceTypeHasValue;
    }
    if (tags != null) {
      _result.tags.addAll(tags);
    }
    if (extraTags != null) {
      _result.extraTags.addAll(extraTags);
    }
    if (extraTagsHasValue != null) {
      _result.extraTagsHasValue = extraTagsHasValue;
    }
    return _result;
  }
  factory GRecipe.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GRecipe.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GRecipe clone() => GRecipe()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GRecipe copyWith(void Function(GRecipe) updates) => super.copyWith((message) => updates(message as GRecipe)) as GRecipe; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GRecipe create() => GRecipe._();
  GRecipe createEmptyInstance() => create();
  static $pb.PbList<GRecipe> createRepeated() => $pb.PbList<GRecipe>();
  @$core.pragma('dart2js:noInline')
  static GRecipe getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GRecipe>(create);
  static GRecipe? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get descriptionHasValue => $_getBF(2);
  @$pb.TagNumber(3)
  set descriptionHasValue($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescriptionHasValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescriptionHasValue() => clearField(3);

  @$pb.TagNumber(4)
  $7.GCategory get category => $_getN(3);
  @$pb.TagNumber(4)
  set category($7.GCategory v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);
  @$pb.TagNumber(4)
  $7.GCategory ensureCategory() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.List<$8.GIngredient> get ingredients => $_getList(4);

  @$pb.TagNumber(6)
  $fixnum.Int64 get publishDate => $_getI64(5);
  @$pb.TagNumber(6)
  set publishDate($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPublishDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearPublishDate() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get expiryDate => $_getI64(6);
  @$pb.TagNumber(7)
  set expiryDate($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasExpiryDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearExpiryDate() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get expiryDateHasValue => $_getBF(7);
  @$pb.TagNumber(8)
  set expiryDateHasValue($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasExpiryDateHasValue() => $_has(7);
  @$pb.TagNumber(8)
  void clearExpiryDateHasValue() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get preparationDuration => $_getN(8);
  @$pb.TagNumber(9)
  set preparationDuration($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPreparationDuration() => $_has(8);
  @$pb.TagNumber(9)
  void clearPreparationDuration() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get totalDuration => $_getN(9);
  @$pb.TagNumber(10)
  set totalDuration($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTotalDuration() => $_has(9);
  @$pb.TagNumber(10)
  void clearTotalDuration() => clearField(10);

  @$pb.TagNumber(11)
  $core.bool get totalDurationHasValue => $_getBF(10);
  @$pb.TagNumber(11)
  set totalDurationHasValue($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasTotalDurationHasValue() => $_has(10);
  @$pb.TagNumber(11)
  void clearTotalDurationHasValue() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isPublished => $_getBF(11);
  @$pb.TagNumber(12)
  set isPublished($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasIsPublished() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsPublished() => clearField(12);

  @$pb.TagNumber(13)
  $core.bool get requiresRobot => $_getBF(12);
  @$pb.TagNumber(13)
  set requiresRobot($core.bool v) { $_setBool(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasRequiresRobot() => $_has(12);
  @$pb.TagNumber(13)
  void clearRequiresRobot() => clearField(13);

  @$pb.TagNumber(14)
  $core.bool get requiresRobotHasValue => $_getBF(13);
  @$pb.TagNumber(14)
  set requiresRobotHasValue($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasRequiresRobotHasValue() => $_has(13);
  @$pb.TagNumber(14)
  void clearRequiresRobotHasValue() => clearField(14);

  @$pb.TagNumber(15)
  $6.GApplianceType get mainApplianceType => $_getN(14);
  @$pb.TagNumber(15)
  set mainApplianceType($6.GApplianceType v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasMainApplianceType() => $_has(14);
  @$pb.TagNumber(15)
  void clearMainApplianceType() => clearField(15);

  @$pb.TagNumber(16)
  $6.GApplianceType get secondaryApplianceType => $_getN(15);
  @$pb.TagNumber(16)
  set secondaryApplianceType($6.GApplianceType v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasSecondaryApplianceType() => $_has(15);
  @$pb.TagNumber(16)
  void clearSecondaryApplianceType() => clearField(16);

  @$pb.TagNumber(17)
  $core.bool get secondaryApplianceTypeHasValue => $_getBF(16);
  @$pb.TagNumber(17)
  set secondaryApplianceTypeHasValue($core.bool v) { $_setBool(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasSecondaryApplianceTypeHasValue() => $_has(16);
  @$pb.TagNumber(17)
  void clearSecondaryApplianceTypeHasValue() => clearField(17);

  @$pb.TagNumber(18)
  $core.List<$core.String> get tags => $_getList(17);

  @$pb.TagNumber(19)
  $core.List<$core.String> get extraTags => $_getList(18);

  @$pb.TagNumber(20)
  $core.bool get extraTagsHasValue => $_getBF(19);
  @$pb.TagNumber(20)
  set extraTagsHasValue($core.bool v) { $_setBool(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasExtraTagsHasValue() => $_has(19);
  @$pb.TagNumber(20)
  void clearExtraTagsHasValue() => clearField(20);
}

class GListOfRecipe extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GListOfRecipe', createEmptyInstance: create)
    ..pc<GRecipe>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: GRecipe.create)
    ..hasRequiredFields = false
  ;

  GListOfRecipe._() : super();
  factory GListOfRecipe({
    $core.Iterable<GRecipe>? items,
  }) {
    final _result = create();
    if (items != null) {
      _result.items.addAll(items);
    }
    return _result;
  }
  factory GListOfRecipe.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GListOfRecipe.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GListOfRecipe clone() => GListOfRecipe()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GListOfRecipe copyWith(void Function(GListOfRecipe) updates) => super.copyWith((message) => updates(message as GListOfRecipe)) as GListOfRecipe; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GListOfRecipe create() => GListOfRecipe._();
  GListOfRecipe createEmptyInstance() => create();
  static $pb.PbList<GListOfRecipe> createRepeated() => $pb.PbList<GListOfRecipe>();
  @$core.pragma('dart2js:noInline')
  static GListOfRecipe getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GListOfRecipe>(create);
  static GListOfRecipe? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GRecipe> get items => $_getList(0);
}

