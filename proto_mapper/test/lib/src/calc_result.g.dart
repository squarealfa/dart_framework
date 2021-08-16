// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calc_result.dart';

// **************************************************************************
// ProtoMapperGenerator
// **************************************************************************

class CalcResultProtoMapper implements ProtoMapper<CalcResult, GCalcResult> {
  const CalcResultProtoMapper();

  @override
  CalcResult fromProto(GCalcResult proto) => _$CalcResultFromProto(proto);

  @override
  GCalcResult toProto(CalcResult entity) => _$CalcResultToProto(entity);

  CalcResult fromJson(String json) =>
      _$CalcResultFromProto(GCalcResult.fromJson(json));
  String toJson(CalcResult entity) => _$CalcResultToProto(entity).writeToJson();

  String toBase64Proto(CalcResult entity) =>
      base64Encode(utf8.encode(entity.toProto().writeToJson()));

  CalcResult fromBase64Proto(String base64Proto) =>
      GCalcResult.fromJson(utf8.decode(base64Decode(base64Proto)))
          .toCalcResult();
}

GCalcResult _$CalcResultToProto(CalcResult instance) {
  var proto = GCalcResult();

  proto.result = instance.result;

  return proto;
}

CalcResult _$CalcResultFromProto(GCalcResult instance) => CalcResult(
      result: instance.result,
    );

extension CalcResultProtoExtension on CalcResult {
  GCalcResult toProto() => _$CalcResultToProto(this);
  String toJson() => _$CalcResultToProto(this).writeToJson();

  static CalcResult fromProto(GCalcResult proto) =>
      _$CalcResultFromProto(proto);
  static CalcResult fromJson(String json) =>
      _$CalcResultFromProto(GCalcResult.fromJson(json));
}

extension GCalcResultProtoExtension on GCalcResult {
  CalcResult toCalcResult() => _$CalcResultFromProto(this);
}
