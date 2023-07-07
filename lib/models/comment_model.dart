class comment_model {
  String? task;
  String? activity;
  String? content;

  comment_model({this.task, this.activity, this.content});

  comment_model.fromJson(Map<String, dynamic> json) {
    task = json['task'];
    activity = json['activity'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task'] = this.task;
    data['activity'] = this.activity;
    data['content'] = this.content;
    return data;
  }
}
