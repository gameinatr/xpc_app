import 'package:json_annotation/json_annotation.dart';
import 'package:xpc_app/models/trainings/next_training_model.dart';
part 'single_course_item_model.g.dart';

@JsonSerializable()
class SingleCourse {
  int id;
  int siteId;
  String title;
  bool draft;
  String videoLink;
  String mobileDescription;
  List<NextTraining> nextTrainings;

  SingleCourse({
    required this.siteId,
    required this.id,
    required this.draft,
    required this.title,
    required this.videoLink,
    required this.mobileDescription,
    required this.nextTrainings,
  });

  factory SingleCourse.fromJson(Map<String, dynamic> json) =>
      _$SingleCourseFromJson(json);

  Map<String, dynamic> toJson() => _$SingleCourseToJson(this);
}
