// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchoolSite _$SchoolSiteFromJson(Map<String, dynamic> json) => SchoolSite(
      customFields: (json['custom_fields'] as List<dynamic>?)
          ?.map((e) => CoachCustomField.fromJson(e as Map<String, dynamic>))
          .toList(),
      domain: json['domain'] as String,
      school: json['school'] as String,
      timezone: json['timezone'] as String,
      title: json['title'] as String,
      user: CoachUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SchoolSiteToJson(SchoolSite instance) =>
    <String, dynamic>{
      'custom_fields': instance.customFields,
      'domain': instance.domain,
      'school': instance.school,
      'timezone': instance.timezone,
      'title': instance.title,
      'user': instance.user,
    };
