// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_multichoice_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionMultichoiceSettings _$ActionMultichoiceSettingsFromJson(
        Map<String, dynamic> json) =>
    ActionMultichoiceSettings(
      incorrectMessage: json['incorrect_message'] as String,
      incorrectMessageColor: json['incorrect_message_color'] as String,
      tryItPeriod: json['try_it_period'] as String,
      tryItPeriodNumber: json['try_it_period_number'] as num,
      text: json['text'] as String,
      subtitle: json['subtitle'] as String,
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => MultichoiceAnswer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ActionMultichoiceSettingsToJson(
        ActionMultichoiceSettings instance) =>
    <String, dynamic>{
      'incorrect_message': instance.incorrectMessage,
      'incorrect_message_color': instance.incorrectMessageColor,
      'try_it_period': instance.tryItPeriod,
      'try_it_period_number': instance.tryItPeriodNumber,
      'text': instance.text,
      'subtitle': instance.subtitle,
      'answers': instance.answers,
    };
