// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_essay_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionEssaySettings _$ActionEssaySettingsFromJson(Map<String, dynamic> json) =>
    ActionEssaySettings(
      errorMessage: json['error_message'] as String,
      errorMessageColor: json['error_message_color'] as String,
      essayMinWordsCount: json['min_count_words'] as num,
    );

Map<String, dynamic> _$ActionEssaySettingsToJson(
        ActionEssaySettings instance) =>
    <String, dynamic>{
      'error_message': instance.errorMessage,
      'error_message_color': instance.errorMessageColor,
      'min_count_words': instance.essayMinWordsCount,
    };
