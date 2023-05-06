// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trackbar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trackbar _$TrackbarFromJson(Map<String, dynamic> json) => Trackbar(
      totalXp: json['total_xp'] as int,
      totalXxp: json['total_xxp'] as int,
      earnedXp: json['earned_xp'] as int,
      earnedXxp: json['earned_xxp'] as int,
    );

Map<String, dynamic> _$TrackbarToJson(Trackbar instance) => <String, dynamic>{
      'total_xp': instance.totalXp,
      'total_xxp': instance.totalXxp,
      'earned_xp': instance.earnedXp,
      'earned_xxp': instance.earnedXxp,
    };
