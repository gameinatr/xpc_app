// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coach_custom_field_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoachCustomField _$CoachCustomFieldFromJson(Map<String, dynamic> json) =>
    CoachCustomField(
      isEditable: json['is_editable_by_student'] as bool,
      id: json['id'] as int,
      order: json['order'] as int,
      slug: json['slug'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$CoachCustomFieldToJson(CoachCustomField instance) =>
    <String, dynamic>{
      'is_editable_by_student': instance.isEditable,
      'id': instance.id,
      'order': instance.order,
      'slug': instance.slug,
      'title': instance.title,
    };
