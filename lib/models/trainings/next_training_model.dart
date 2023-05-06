import 'package:json_annotation/json_annotation.dart';
part 'next_training_model.g.dart';

@JsonSerializable()
class NextTraining {
  int id;
  num? xp;
  num? xxp;
  String slug;
  bool draft;
  num order;
  String title;
  String poster;
  @JsonKey(name: 'parent_id')
  int parentId;
  String thumbnail;
  @JsonKey(name: 'parent_name')
  String parentName;
  @JsonKey(name: 'module_order')
  num moduleOrder;
  @JsonKey(name: 'awaiting_status')
  String awaitingStatus;

  NextTraining(
      {required this.id,
      required this.xp,
      required this.xxp,
      required this.slug,
      required this.draft,
      required this.order,
      required this.title,
      required this.poster,
      required this.parentId,
      required this.thumbnail,
      required this.parentName,
      required this.moduleOrder,
      required this.awaitingStatus});

  factory NextTraining.fromJson(Map<String, dynamic> json) =>
      _$NextTrainingFromJson(json);

  Map<String, dynamic> toJson() => _$NextTrainingToJson(this);
}
