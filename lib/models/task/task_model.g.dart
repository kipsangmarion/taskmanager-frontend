// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'] as int?,
      user: json['user'] as int?,
      title: json['title'] as String?,
      tag: json['tag'] as String?,
      desc: json['desc'] as String?,
      status: json['status'] as String?,
      hours: json['hours'] as int?,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      planned_start_date: json['planned_start_date'] == null
          ? null
          : DateTime.parse(json['planned_start_date'] as String),
      planned_end_date: json['planned_end_date'] == null
          ? null
          : DateTime.parse(json['planned_end_date'] as String),
      actual_start_date: json['actual_start_date'] == null
          ? null
          : DateTime.parse(json['actual_start_date'] as String),
      actual_end_date: json['actual_end_date'] == null
          ? null
          : DateTime.parse(json['actual_end_date'] as String),
      content: json['content'] as String?,
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'title': instance.title,
      'tag': instance.tag,
      'desc': instance.desc,
      'status': instance.status,
      'hours': instance.hours,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'planned_start_date': instance.planned_start_date?.toIso8601String(),
      'planned_end_date': instance.planned_end_date?.toIso8601String(),
      'actual_start_date': instance.actual_start_date?.toIso8601String(),
      'actual_end_date': instance.actual_end_date?.toIso8601String(),
      'content': instance.content,
    };
