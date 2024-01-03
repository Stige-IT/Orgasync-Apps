part of "../../project.dart";

class TaskModel {
  String? id;
  String? idProject;
  String? name;
  String? description;
  Status? status;
  Assignee? assignee;
  Priority? priority;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;

  TaskModel(
      {this.id,
      this.idProject,
      this.name,
      this.description,
      this.status,
      this.assignee,
      this.priority,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.updatedAt});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idProject = json['id_project'];
    name = json['name'];
    description = json['description'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    assignee =
        json['assignee'] != null ? Assignee.fromJson(json['assignee']) : null;
    priority =
        json['priority'] != null ? Priority.fromJson(json['priority']) : null;
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Assignee {
  String? id;
  Employee? employee;

  Assignee({this.id, this.employee});

  Assignee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employee =
        json['employee'] != null ? Employee.fromJson(json['employee']) : null;
  }

  // to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee'] = employee?.toJson();
    return data;
  }
}
