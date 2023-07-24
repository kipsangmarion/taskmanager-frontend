import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_model.g.dart';

@JsonSerializable()
class ActivityModel extends Equatable {
  const ActivityModel({this.id, this.task, this.title, this.desc, this.status, this.hours, this.created_at, this.updated_at, this.content});

  final int? id;
  final int? task;
  final String? title;
  final String? desc;
  final String? status;
  final double? hours;
  final DateTime? created_at;
  final DateTime? updated_at;
  final String? content;

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return _$ActivityModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);

  ActivityModel copyWith({
    int? id,
    int? task,
    String? title,
    String? desc,
    String? status,
    double? hours,
    DateTime? created_at,
    DateTime? updated_at,
    String? content,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      task: task?? this.task,
      title: title?? this.title,
      desc: desc?? this.desc,
      status: status?? this.status,
      hours: hours?? this.hours,
      created_at: created_at?? this.created_at,
      updated_at: updated_at?? this.updated_at,
      content: content?? this.content,
    );
  }

  @override
  List<Object?> get props => [id, task, title, desc, status, hours, created_at, updated_at, content];
}