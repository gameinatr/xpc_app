// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_training_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleTraining _$SingleTrainingFromJson(Map<String, dynamic> json) =>
    SingleTraining(
      id: json['id'] as num,
      xp: json['xp'] as num?,
      xxp: json['xxp'] as num?,
      slug: json['slug'] as String,
      draft: json['draft'] as bool,
      order: json['order'] as num,
      title: json['title'] as String,
      poster: json['poster'] as String,
      actions: (json['actions'] as List<dynamic>)
          .map((e) => TrainingAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: json['notes'] as String,
      parentId: json['parent_id'] as num,
      thumbnail: json['thumbnail'] as String,
      parentName: json['parent_name'] as String,
      moduleOrder: json['module_order'] as num,
      awaitingStatus: json['awaiting_status'] as String,
      videoUrl: json['video_url'] as String,
      nextTraining: json['next_training'] == null
          ? null
          : NextTraining.fromJson(
              json['next_training'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SingleTrainingToJson(SingleTraining instance) =>
    <String, dynamic>{
      'id': instance.id,
      'xp': instance.xp,
      'xxp': instance.xxp,
      'slug': instance.slug,
      'draft': instance.draft,
      'order': instance.order,
      'title': instance.title,
      'poster': instance.poster,
      'actions': instance.actions,
      'notes': instance.notes,
      'next_training': instance.nextTraining,
      'parent_id': instance.parentId,
      'thumbnail': instance.thumbnail,
      'parent_name': instance.parentName,
      'module_order': instance.moduleOrder,
      'awaiting_status': instance.awaitingStatus,
      'video_url': instance.videoUrl,
    };
