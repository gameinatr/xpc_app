import 'package:json_annotation/json_annotation.dart';
part 'login_course_model.g.dart';

@JsonSerializable()
class LoginCourseItem {
  int id;
  String link;
  @JsonKey(name: 'module_count')
  num moduleCount;
  String poster;
  num progress;
  String title;

  LoginCourseItem(
      {required this.id,
      required this.link,
      required this.moduleCount,
      required this.poster,
      required this.progress,
      required this.title});

  factory LoginCourseItem.fromJson(Map<String, dynamic> json) =>
      _$LoginCourseItemFromJson(json);

  Map<String, dynamic> toJson() => _$LoginCourseItemToJson(this);
}
