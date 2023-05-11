import 'package:json_annotation/json_annotation.dart';
import 'package:xpc_app/models/site/coach_custom_field_model.dart';
import 'package:xpc_app/models/users/coach_user_model.dart';
part 'site_model.g.dart';

@JsonSerializable()
class SchoolSite {
  @JsonKey(name: 'custom_fields')
  List<CoachCustomField>? customFields;
  String domain;
  String school;
  String timezone;
  String title;
  CoachUser user;

  SchoolSite(
      {required this.customFields,
      required this.domain,
      required this.school,
      required this.timezone,
      required this.title,
      required this.user});

  factory SchoolSite.fromJson(Map<String, dynamic> json) =>
      _$SchoolSiteFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolSiteToJson(this);
}
