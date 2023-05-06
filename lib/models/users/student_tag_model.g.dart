// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentTag _$StudentTagFromJson(Map<String, dynamic> json) => StudentTag(
      id: json['id'] as int,
      title: json['title'] as String,
      user: json['user'] as int,
    );

Map<String, dynamic> _$StudentTagToJson(StudentTag instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'title': instance.title,
    };
