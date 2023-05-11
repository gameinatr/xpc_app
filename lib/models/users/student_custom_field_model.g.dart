// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_custom_field_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentCustomField _$StudentCustomFieldFromJson(Map<String, dynamic> json) =>
    StudentCustomField(
      site: json['field_site'] as int,
      slug: json['field_slug'] as String,
      title: json['field_title'] as String,
      value: json['value'] as String?,
      editable: json['editable'] as bool?,
    );

Map<String, dynamic> _$StudentCustomFieldToJson(StudentCustomField instance) =>
    <String, dynamic>{
      'field_site': instance.site,
      'field_slug': instance.slug,
      'field_title': instance.title,
      'value': instance.value,
      'editable': instance.editable,
    };
