import 'package:json_annotation/json_annotation.dart';
part 'coach_user_model.g.dart';

@JsonSerializable()
class CoachUser {
  int id;
  String email;
  String photo;
  @JsonKey(name: 'first_name')
  String firstName;
  @JsonKey(name: 'last_name')
  String lastName;
  @JsonKey(name: 'coach_active')
  bool isCoachActive;
  @JsonKey(name: 'service_email')
  String serviceEmail;

  CoachUser(
      {required this.id,
      required this.email,
      required this.photo,
      required this.firstName,
      required this.lastName,
      required this.isCoachActive,
      required this.serviceEmail});

  factory CoachUser.fromJson(Map<String, dynamic> json) =>
      _$CoachUserFromJson(json);

  Map<String, dynamic> toJson() => _$CoachUserToJson(this);
}
