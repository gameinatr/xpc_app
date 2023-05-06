import 'package:json_annotation/json_annotation.dart';
import 'package:xpc_app/models/actions/action_model.dart';
import 'next_training_model.dart';
part 'single_training_model.g.dart';

@JsonSerializable()
class SingleTraining {
  num id;
  num? xp;
  num? xxp;
  String slug;
  bool draft;
  num order;
  String title;
  String poster;
  List<TrainingAction> actions;
  String notes;
  @JsonKey(name: 'next_training')
  NextTraining? nextTraining;
  @JsonKey(name: 'parent_id')
  num parentId;
  String thumbnail;
  @JsonKey(name: 'parent_name')
  String parentName;
  @JsonKey(name: 'module_order')
  num moduleOrder;
  @JsonKey(name: 'awaiting_status')
  String awaitingStatus;
  @JsonKey(name: 'video_url')
  String videoUrl;

  SingleTraining({
    required this.id,
    required this.xp,
    required this.xxp,
    required this.slug,
    required this.draft,
    required this.order,
    required this.title,
    required this.poster,
    required this.actions,
    required this.notes,
    required this.parentId,
    required this.thumbnail,
    required this.parentName,
    required this.moduleOrder,
    required this.awaitingStatus,
    required this.videoUrl,
    required this.nextTraining,
  });

  factory SingleTraining.fromJson(Map<String, dynamic> json) =>
      _$SingleTrainingFromJson(json);

  Map<String, dynamic> toJson() => _$SingleTrainingToJson(this);
}
