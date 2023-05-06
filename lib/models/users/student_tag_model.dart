import 'package:json_annotation/json_annotation.dart';
part 'student_tag_model.g.dart';

@JsonSerializable()
class StudentTag {
  int id;
  int user;
  String title;

  StudentTag({required this.id, required this.title, required this.user});

  factory StudentTag.fromJson(Map<String, dynamic> json) =>
      _$StudentTagFromJson(json);

  Map<String, dynamic> toJson() => _$StudentTagToJson(this);
}
