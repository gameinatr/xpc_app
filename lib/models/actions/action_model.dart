import 'package:json_annotation/json_annotation.dart';
import 'action_essay_settings.dart';
import 'action_multichoice_settings.dart';
import 'action_multichoice_last_answers.dart';
part 'action_model.g.dart';

@JsonSerializable()
class TrainingAction {
  int id;
  int entity;
  int module;
  String image;
  String title;
  String description;
  String label;
  String type;
  num value;
  List<int>? addTags;
  List<int>? removeTags;
  // TOASK: y i need nullable for empty arrays?
  @JsonKey(name: 'display_type')
  String displayType;
  @JsonKey(name: 'is_completed')
  bool isCompleted;

  String? essay;
  @JsonKey(name: 'essay_setting')
  ActionEssaySettings? essaySettings;

  @JsonKey(name: 'question')
  ActionMultichoiceSettings? multichoiceSettings;

  @JsonKey(name: 'last_answers')
  ActionMultichoiceLastAnswers? lastAnswers;

  TrainingAction({
    required this.id,
    required this.entity,
    required this.module,
    required this.image,
    required this.title,
    required this.description,
    required this.label,
    required this.type,
    required this.value,
    required this.addTags,
    required this.removeTags,
    required this.displayType,
    required this.isCompleted,
    this.essay = '',
    this.essaySettings,
    this.multichoiceSettings,
    this.lastAnswers,
  });

  factory TrainingAction.fromJson(Map<String, dynamic> json) =>
      _$TrainingActionFromJson(json);

  Map<String, dynamic> toJson() => _$TrainingActionToJson(this);
}
