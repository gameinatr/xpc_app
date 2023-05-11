// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coach_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoachUser _$CoachUserFromJson(Map<String, dynamic> json) => CoachUser(
      id: json['id'] as int,
      email: json['email'] as String,
      photo: json['photo'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      isCoachActive: json['coach_active'] as bool,
      serviceEmail: json['service_email'] as String,
    );

Map<String, dynamic> _$CoachUserToJson(CoachUser instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'photo': instance.photo,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'coach_active': instance.isCoachActive,
      'service_email': instance.serviceEmail,
    };
