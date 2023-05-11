// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_course_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleCourse _$SingleCourseFromJson(Map<String, dynamic> json) => SingleCourse(
      siteId: json['siteId'] as int,
      id: json['id'] as int,
      draft: json['draft'] as bool,
      title: json['title'] as String,
      videoLink: json['videoLink'] as String,
      description: json['description'] as String,
      nextTrainings: (json['nextTrainings'] as List<dynamic>)
          .map((e) => NextTraining.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SingleCourseToJson(SingleCourse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'siteId': instance.siteId,
      'title': instance.title,
      'draft': instance.draft,
      'videoLink': instance.videoLink,
      'description': instance.description,
      'nextTrainings': instance.nextTrainings,
    };
