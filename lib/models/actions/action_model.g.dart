// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrainingAction _$TrainingActionFromJson(Map<String, dynamic> json) =>
    TrainingAction(
      id: json['id'] as int,
      entity: json['entity'] as int,
      module: json['module'] as int,
      image: json['image'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      label: json['label'] as String,
      type: json['type'] as String,
      value: json['value'] as num,
      addTags:
          (json['addTags'] as List<dynamic>?)?.map((e) => e as int).toList(),
      removeTags:
          (json['removeTags'] as List<dynamic>?)?.map((e) => e as int).toList(),
      displayType: json['display_type'] as String,
      isCompleted: json['is_completed'] as bool,
      essay: json['essay'] as String? ?? '',
      essaySettings: json['essay_setting'] == null
          ? null
          : ActionEssaySettings.fromJson(
              json['essay_setting'] as Map<String, dynamic>),
      multichoiceSettings: json['question'] == null
          ? null
          : ActionMultichoiceSettings.fromJson(
              json['question'] as Map<String, dynamic>),
      lastAnswers: json['last_answers'] == null
          ? null
          : ActionMultichoiceLastAnswers.fromJson(
              json['last_answers'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrainingActionToJson(TrainingAction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'entity': instance.entity,
      'module': instance.module,
      'image': instance.image,
      'title': instance.title,
      'description': instance.description,
      'label': instance.label,
      'type': instance.type,
      'value': instance.value,
      'addTags': instance.addTags,
      'removeTags': instance.removeTags,
      'display_type': instance.displayType,
      'is_completed': instance.isCompleted,
      'essay': instance.essay,
      'essay_setting': instance.essaySettings,
      'question': instance.multichoiceSettings,
      'last_answers': instance.lastAnswers,
    };
