import 'package:json_annotation/json_annotation.dart';
part 'action_multichoice_last_answers.g.dart';

@JsonSerializable()
class ActionMultichoiceLastAnswers {
  List<int> answers;
  bool correct;
  String created;

  ActionMultichoiceLastAnswers(
      {required this.answers, required this.correct, required this.created});

  factory ActionMultichoiceLastAnswers.fromJson(Map<String, dynamic> json) =>
      _$ActionMultichoiceLastAnswersFromJson(json);

  Map<String, dynamic> toJson() => _$ActionMultichoiceLastAnswersToJson(this);
}
