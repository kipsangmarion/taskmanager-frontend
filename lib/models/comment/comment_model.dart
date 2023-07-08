import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel extends Equatable {
  const CommentModel({this.id, this.task, this.activity, this.content});

  final int? id;
  final int? task;
  final int? activity;
  final String? content;

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return _$CommentModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  CommentModel copyWith({
    int? id,
    int? task,
    int? activity,
    String? content,
  }) {
    return CommentModel(
      id: id ?? this.id,
      task: task ?? this.task,
      activity: activity ?? this.activity,
      content: content?? this.content,
    );
  }

  @override
  List<Object?> get props => [id, task, activity, content];
}