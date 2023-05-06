// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_multichoice_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultichoiceAnswer _$MultichoiceAnswerFromJson(Map<String, dynamic> json) =>
    MultichoiceAnswer(
      text: json['text'] as String,
      id: json['id'] as int,
      addTags:
          (json['addTags'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$MultichoiceAnswerToJson(MultichoiceAnswer instance) =>
    <String, dynamic>{
      'text': instance.text,
      'id': instance.id,
      'addTags': instance.addTags,
    };
