// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'next_training_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NextTraining _$NextTrainingFromJson(Map<String, dynamic> json) => NextTraining(
      id: json['id'] as int,
      xp: json['xp'] as num?,
      xxp: json['xxp'] as num?,
      slug: json['slug'] as String,
      draft: json['draft'] as bool,
      order: json['order'] as num,
      title: json['title'] as String,
      poster: json['poster'] as String,
      parentId: json['parent_id'] as int,
      thumbnail: json['thumbnail'] as String,
      parentName: json['parent_name'] as String,
      moduleOrder: json['module_order'] as num,
      awaitingStatus: json['awaiting_status'] as String,
    );

Map<String, dynamic> _$NextTrainingToJson(NextTraining instance) =>
    <String, dynamic>{
      'id': instance.id,
      'xp': instance.xp,
      'xxp': instance.xxp,
      'slug': instance.slug,
      'draft': instance.draft,
      'order': instance.order,
      'title': instance.title,
      'poster': instance.poster,
      'parent_id': instance.parentId,
      'thumbnail': instance.thumbnail,
      'parent_name': instance.parentName,
      'module_order': instance.moduleOrder,
      'awaiting_status': instance.awaitingStatus,
    };
