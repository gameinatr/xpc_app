import 'package:json_annotation/json_annotation.dart';
part 'student_custom_field_model.g.dart';

@JsonSerializable()
class StudentCustomField {
  @JsonKey(name: 'field_site')
  int site;
  @JsonKey(name: 'field_slug')
  String slug;
  @JsonKey(name: 'field_title')
  String title;
  String value;
  bool editable;

  StudentCustomField(
      {required this.site,
      required this.slug,
      required this.title,
      required this.value,
      required this.editable});

  factory StudentCustomField.fromJson(Map<String, dynamic> json) =>
      _$StudentCustomFieldFromJson(json);

  Map<String, dynamic> toJson() => _$StudentCustomFieldToJson(this);
}
