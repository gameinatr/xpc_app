// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_multichoice_last_answers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionMultichoiceLastAnswers _$ActionMultichoiceLastAnswersFromJson(
        Map<String, dynamic> json) =>
    ActionMultichoiceLastAnswers(
      answers: (json['answers'] as List<dynamic>).map((e) => e as int).toList(),
      correct: json['correct'] as bool,
      created: json['created'] as String,
    );

Map<String, dynamic> _$ActionMultichoiceLastAnswersToJson(
        ActionMultichoiceLastAnswers instance) =>
    <String, dynamic>{
      'answers': instance.answers,
      'correct': instance.correct,
      'created': instance.created,
    };
