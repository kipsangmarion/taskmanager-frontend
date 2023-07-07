class task_model {
  String? user;
  String? title;
  String? tag;
  String? desc;
  String? status;
  String? hours;
  String? createdAt;
  String? updatedAt;
  String? plannedStartDate;
  String? plannedEndDate;
  String? actualStartDate;
  String? actualEndDate;
  String? content;

  task_model(
      {this.user,
        this.title,
        this.tag,
        this.desc,
        this.status,
        this.hours,
        this.createdAt,
        this.updatedAt,
        this.plannedStartDate,
        this.plannedEndDate,
        this.actualStartDate,
        this.actualEndDate,
        this.content});

  task_model.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    title = json['title'];
    tag = json['tag'];
    desc = json['desc'];
    status = json['status'];
    hours = json['hours'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    plannedStartDate = json['planned_start_date'];
    plannedEndDate = json['planned_end_date'];
    actualStartDate = json['actual_start_date'];
    actualEndDate = json['actual_end_date'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['title'] = this.title;
    data['tag'] = this.tag;
    data['desc'] = this.desc;
    data['status'] = this.status;
    data['hours'] = this.hours;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['planned_start_date'] = this.plannedStartDate;
    data['planned_end_date'] = this.plannedEndDate;
    data['actual_start_date'] = this.actualStartDate;
    data['actual_end_date'] = this.actualEndDate;
    data['content'] = this.content;
    return data;
  }
}
