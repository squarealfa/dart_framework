///
//  Generated code. Do not modify.
//  source: ingredient.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'component.pb.dart' as $0;

class GIngredient extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GIngredient',
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'description')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'quantity')
    ..a<$core.double>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'precision',
        $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cookingDuration', $pb.PbFieldType.OD,
        protoName: 'cookingDuration')
    ..aOM<$0.GComponent>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mainComponent',
        protoName: 'mainComponent', subBuilder: $0.GComponent.create)
    ..pc<$0.GComponent>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'otherComponents', $pb.PbFieldType.PM,
        protoName: 'otherComponents', subBuilder: $0.GComponent.create)
    ..aOM<$0.GComponent>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alternativeComponent',
        protoName: 'alternativeComponent', subBuilder: $0.GComponent.create)
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alternativeComponentHasValue',
        protoName: 'alternativeComponentHasValue')
    ..pc<$0.GComponent>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'secondaryComponents', $pb.PbFieldType.PM,
        protoName: 'secondaryComponents', subBuilder: $0.GComponent.create)
    ..aOB(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'secondaryComponentsHasValue', protoName: 'secondaryComponentsHasValue')
    ..hasRequiredFields = false;

  GIngredient._() : super();
  factory GIngredient({
    $core.String? description,
    $core.String? quantity,
    $core.double? precision,
    $core.double? cookingDuration,
    $0.GComponent? mainComponent,
    $core.Iterable<$0.GComponent>? otherComponents,
    $0.GComponent? alternativeComponent,
    $core.bool? alternativeComponentHasValue,
    $core.Iterable<$0.GComponent>? secondaryComponents,
    $core.bool? secondaryComponentsHasValue,
  }) {
    final _result = create();
    if (description != null) {
      _result.description = description;
    }
    if (quantity != null) {
      _result.quantity = quantity;
    }
    if (precision != null) {
      _result.precision = precision;
    }
    if (cookingDuration != null) {
      _result.cookingDuration = cookingDuration;
    }
    if (mainComponent != null) {
      _result.mainComponent = mainComponent;
    }
    if (otherComponents != null) {
      _result.otherComponents.addAll(otherComponents);
    }
    if (alternativeComponent != null) {
      _result.alternativeComponent = alternativeComponent;
    }
    if (alternativeComponentHasValue != null) {
      _result.alternativeComponentHasValue = alternativeComponentHasValue;
    }
    if (secondaryComponents != null) {
      _result.secondaryComponents.addAll(secondaryComponents);
    }
    if (secondaryComponentsHasValue != null) {
      _result.secondaryComponentsHasValue = secondaryComponentsHasValue;
    }
    return _result;
  }
  factory GIngredient.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GIngredient.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GIngredient clone() => GIngredient()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GIngredient copyWith(void Function(GIngredient) updates) =>
      super.copyWith((message) => updates(message as GIngredient))
          as GIngredient; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GIngredient create() => GIngredient._();
  GIngredient createEmptyInstance() => create();
  static $pb.PbList<GIngredient> createRepeated() => $pb.PbList<GIngredient>();
  @$core.pragma('dart2js:noInline')
  static GIngredient getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GIngredient>(create);
  static GIngredient? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get description => $_getSZ(0);
  @$pb.TagNumber(1)
  set description($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescription() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get quantity => $_getSZ(1);
  @$pb.TagNumber(2)
  set quantity($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasQuantity() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuantity() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get precision => $_getN(2);
  @$pb.TagNumber(3)
  set precision($core.double v) {
    $_setDouble(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPrecision() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrecision() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get cookingDuration => $_getN(3);
  @$pb.TagNumber(4)
  set cookingDuration($core.double v) {
    $_setDouble(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasCookingDuration() => $_has(3);
  @$pb.TagNumber(4)
  void clearCookingDuration() => clearField(4);

  @$pb.TagNumber(5)
  $0.GComponent get mainComponent => $_getN(4);
  @$pb.TagNumber(5)
  set mainComponent($0.GComponent v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasMainComponent() => $_has(4);
  @$pb.TagNumber(5)
  void clearMainComponent() => clearField(5);
  @$pb.TagNumber(5)
  $0.GComponent ensureMainComponent() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.List<$0.GComponent> get otherComponents => $_getList(5);

  @$pb.TagNumber(7)
  $0.GComponent get alternativeComponent => $_getN(6);
  @$pb.TagNumber(7)
  set alternativeComponent($0.GComponent v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasAlternativeComponent() => $_has(6);
  @$pb.TagNumber(7)
  void clearAlternativeComponent() => clearField(7);
  @$pb.TagNumber(7)
  $0.GComponent ensureAlternativeComponent() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.bool get alternativeComponentHasValue => $_getBF(7);
  @$pb.TagNumber(8)
  set alternativeComponentHasValue($core.bool v) {
    $_setBool(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasAlternativeComponentHasValue() => $_has(7);
  @$pb.TagNumber(8)
  void clearAlternativeComponentHasValue() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<$0.GComponent> get secondaryComponents => $_getList(8);

  @$pb.TagNumber(10)
  $core.bool get secondaryComponentsHasValue => $_getBF(9);
  @$pb.TagNumber(10)
  set secondaryComponentsHasValue($core.bool v) {
    $_setBool(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasSecondaryComponentsHasValue() => $_has(9);
  @$pb.TagNumber(10)
  void clearSecondaryComponentsHasValue() => clearField(10);
}
