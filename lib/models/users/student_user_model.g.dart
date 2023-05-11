// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentUser _$StudentUserFromJson(Map<String, dynamic> json) => StudentUser(
      id: json['id'] as int,
      bio: json['bio'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      photo: json['photo'] as String,
      phone: json['phone'] as String,
      badges: (json['badges'] as List<dynamic>?)?.map((e) => e as int).toList(),
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      isActive: json['is_active'] as bool,
      jobTitle: json['job_title'] as String,
      magicToken: json['magic_token'] as String,
      studentCustomFields: (json['student_custom_field'] as List<dynamic>?)
          ?.map((e) => StudentCustomField.fromJson(e as Map<String, dynamic>))
          .toList(),
      studentTags: (json['user_tags'] as List<dynamic>?)
          ?.map((e) => StudentTag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StudentUserToJson(StudentUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bio': instance.bio,
      'email': instance.email,
      'name': instance.name,
      'photo': instance.photo,
      'phone': instance.phone,
      'badges': instance.badges,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'is_active': instance.isActive,
      'job_title': instance.jobTitle,
      'magic_token': instance.magicToken,
      'student_custom_field': instance.studentCustomFields,
      'user_tags': instance.studentTags,
    };
