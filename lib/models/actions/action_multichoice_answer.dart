import 'package:json_annotation/json_annotation.dart';
part 'action_multichoice_answer.g.dart';

@JsonSerializable()
class MultichoiceAnswer {
  String text;
  int id;
  List<int>? addTags;

  MultichoiceAnswer(
      {required this.text, required this.id, required this.addTags});

  factory MultichoiceAnswer.fromJson(Map<String, dynamic> json) =>
      _$MultichoiceAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$MultichoiceAnswerToJson(this);
}
