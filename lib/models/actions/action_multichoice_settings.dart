import 'package:json_annotation/json_annotation.dart';
import 'package:xpc_app/models/actions/action_multichoice_answer.dart';
part 'action_multichoice_settings.g.dart';

@JsonSerializable()
class ActionMultichoiceSettings {
  @JsonKey(name: 'incorrect_message')
  String incorrectMessage;
  @JsonKey(name: 'incorrect_message_color')
  String incorrectMessageColor;
  @JsonKey(name: 'try_it_period')
  String tryItPeriod;
  @JsonKey(name: 'try_it_period_number')
  num tryItPeriodNumber;
  String text;
  String subtitle;
  List<MultichoiceAnswer>? answers;

  ActionMultichoiceSettings({
    required this.incorrectMessage,
    required this.incorrectMessageColor,
    required this.tryItPeriod,
    required this.tryItPeriodNumber,
    required this.text,
    required this.subtitle,
    required this.answers,
  });

  factory ActionMultichoiceSettings.fromJson(Map<String, dynamic> json) =>
      _$ActionMultichoiceSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$ActionMultichoiceSettingsToJson(this);
}
