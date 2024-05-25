class TodayTaskModel {
  int? success;
  List<Data>? data;

  TodayTaskModel({this.success, this.data});

  TodayTaskModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? taskName;
  String? taskTime;
  String? type;

  Data({this.id, this.taskName, this.taskTime, this.type});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskName = json['task_name'];
    taskTime = json['task_time'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['task_name'] = this.taskName;
    data['task_time'] = this.taskTime;
    data['type'] = this.type;
    return data;
  }
}