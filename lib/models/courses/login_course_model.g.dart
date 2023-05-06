// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginCourseItem _$LoginCourseItemFromJson(Map<String, dynamic> json) =>
    LoginCourseItem(
      id: json['id'] as int,
      link: json['link'] as String,
      moduleCount: json['module_count'] as num,
      poster: json['poster'] as String,
      progress: json['progress'] as num,
      title: json['title'] as String,
    );

Map<String, dynamic> _$LoginCourseItemToJson(LoginCourseItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'link': instance.link,
      'module_count': instance.moduleCount,
      'poster': instance.poster,
      'progress': instance.progress,
      'title': instance.title,
    };
