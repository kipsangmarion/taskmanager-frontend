import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel extends Equatable {
  const TaskModel({this.id, this.user, this.title, this.tag, this.desc, this.status, this.hours, this.created_at, this.updated_at, this.planned_start_date, this.planned_end_date, this.actual_start_date, this.actual_end_date, this.content});

  final int? id;
  final int? user;
  final String? title;
  final String? tag;
  final String? desc;
  final String? status;
  final int? hours;
  final DateTime? created_at;
  final DateTime? updated_at;
  final DateTime? planned_start_date;
  final DateTime? planned_end_date;
  final DateTime? actual_start_date;
  final DateTime? actual_end_date;
  final String? content;

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return _$TaskModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  TaskModel copyWith({
    int? id,
    int? user,
    String? title,
    String? tag,
    String? desc,
    String? status,
    int? hours,
    DateTime? created_at,
    DateTime? updated_at,
    DateTime? planned_start_date,
    DateTime? planned_end_date,
    DateTime? actual_start_date,
    DateTime? actual_end_date,
    String? content,
  }) {
    return TaskModel(
      id: id ?? this.id,
      user: user?? this.user,
      title: title?? this.title,
      tag: tag?? this.tag,
      desc: desc?? this.desc,
      status: status?? this.status,
      hours: hours?? this.hours,
      created_at: created_at?? this.created_at,
      updated_at: updated_at?? this.updated_at,
      planned_start_date: planned_start_date?? this.planned_start_date,
      planned_end_date: planned_end_date?? this.planned_end_date,
      actual_start_date: actual_start_date?? this.actual_start_date,
      actual_end_date: actual_end_date?? this.actual_end_date,
      content: content?? this.content,
    );
  }

  @override
  List<Object?> get props => [id, user, title, tag, desc, status, hours, created_at, updated_at, planned_start_date, planned_end_date, actual_start_date, actual_end_date, content];
}