import 'package:json_annotation/json_annotation.dart';
import 'package:xpc_app/models/users/student_custom_field_model.dart';
import 'package:xpc_app/models/users/student_tag_model.dart';
part 'user_model.g.dart';

@JsonSerializable()
class User {
  int id;
  String bio;
  String email;
  String name;
  String photo;
  String phone;
  List<int>? badges;
  @JsonKey(name: 'first_name')
  String firstName;
  @JsonKey(name: 'last_name')
  String lastName;
  @JsonKey(name: 'is_active')
  bool isActive;
  @JsonKey(name: 'job_title')
  String jobTitle;
  @JsonKey(name: 'magic_token')
  String magicToken;
  @JsonKey(name: 'student_custom_field')
  List<StudentCustomField>? studentCustomFields;
  @JsonKey(name: 'user_tags')
  List<StudentTag>? studentTags;

  User(
      {required this.id,
      required this.bio,
      required this.email,
      required this.name,
      required this.photo,
      required this.phone,
      required this.badges,
      required this.firstName,
      required this.lastName,
      required this.isActive,
      required this.jobTitle,
      required this.magicToken,
      this.studentCustomFields,
      this.studentTags});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
