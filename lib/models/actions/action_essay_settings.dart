import 'package:json_annotation/json_annotation.dart';
part 'action_essay_settings.g.dart';

@JsonSerializable()
class ActionEssaySettings {
  @JsonKey(name: 'error_message')
  String errorMessage;
  @JsonKey(name: 'error_message_color')
  String errorMessageColor;
  @JsonKey(name: 'min_count_words')
  num essayMinWordsCount;

  ActionEssaySettings(
      {required this.errorMessage,
      required this.errorMessageColor,
      required this.essayMinWordsCount});

  factory ActionEssaySettings.fromJson(Map<String, dynamic> json) =>
      _$ActionEssaySettingsFromJson(json);

  Map<String, dynamic> toJson() => _$ActionEssaySettingsToJson(this);
}
