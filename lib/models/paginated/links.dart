import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'links.g.dart';

@JsonSerializable()
class Links extends Equatable {
  const Links({this.next, this.previous});

  final String? next;
  final String? previous;

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);

  Links copyWith({
    String? next,
    String? previous,
  }) {
    return Links(
      next: next ?? this.next,
      previous: previous ?? this.previous,
    );
  }

  @override
  List<Object?> get props => [next, previous];
}