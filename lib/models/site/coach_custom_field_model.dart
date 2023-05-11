import 'package:json_annotation/json_annotation.dart';
part 'coach_custom_field_model.g.dart';

@JsonSerializable()
class CoachCustomField {
  @JsonKey(name: 'is_editable_by_student')
  bool isEditable;
  int id;
  int order;
  String slug;
  String title;

  CoachCustomField(
      {required this.isEditable,
      required this.id,
      required this.order,
      required this.slug,
      required this.title});

  factory CoachCustomField.fromJson(Map<String, dynamic> json) =>
      _$CoachCustomFieldFromJson(json);

  Map<String, dynamic> toJson() => _$CoachCustomFieldToJson(this);
}
