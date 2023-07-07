class activity_model {
  String? task;
  String? title;
  String? desc;
  String? status;
  String? hours;
  String? createdAt;
  String? updatedAt;
  String? content;

  activity_model(
      {this.task,
        this.title,
        this.desc,
        this.status,
        this.hours,
        this.createdAt,
        this.updatedAt,
        this.content});

  activity_model.fromJson(Map<String, dynamic> json) {
    task = json['task'];
    title = json['title'];
    desc = json['desc'];
    status = json['status'];
    hours = json['hours'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task'] = this.task;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['status'] = this.status;
    data['hours'] = this.hours;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['content'] = this.content;
    return data;
  }
}
