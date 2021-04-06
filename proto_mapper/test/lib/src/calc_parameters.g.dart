// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calc_parameters.dart';

// **************************************************************************
// ProtoMapperGenerator
// **************************************************************************

class CalcParametersProtoMapper
    implements ProtoMapper<CalcParameters, GCalcParameters> {
  static final CalcParametersProtoMapper _singleton =
      CalcParametersProtoMapper._();

  CalcParametersProtoMapper._();
  factory CalcParametersProtoMapper() => _singleton;

  @override
  CalcParameters fromProto(GCalcParameters proto) =>
      _$CalcParametersFromProto(proto);

  @override
  GCalcParameters toProto(CalcParameters entity) =>
      _$CalcParametersToProto(entity);

  CalcParameters fromJson(String json) =>
      _$CalcParametersFromProto(GCalcParameters.fromJson(json));
  String toJson(CalcParameters entity) =>
      _$CalcParametersToProto(entity).writeToJson();
}

GCalcParameters _$CalcParametersToProto(CalcParameters instance) {
  var proto = GCalcParameters();

  proto.parameter1 = instance.parameter1;
  proto.parameter2 = instance.parameter2;

  return proto;
}

CalcParameters _$CalcParametersFromProto(GCalcParameters instance) =>
    CalcParameters(
      parameter1: instance.parameter1,
      parameter2: instance.parameter2,
    );

extension CalcParametersProtoExtension on CalcParameters {
  GCalcParameters toProto() => _$CalcParametersToProto(this);
  String toJson() => _$CalcParametersToProto(this).writeToJson();

  static CalcParameters fromProto(GCalcParameters proto) =>
      _$CalcParametersFromProto(proto);
  static CalcParameters fromJson(String json) =>
      _$CalcParametersFromProto(GCalcParameters.fromJson(json));
}

extension GCalcParametersProtoExtension on GCalcParameters {
  CalcParameters toCalcParameters() => _$CalcParametersFromProto(this);
}
