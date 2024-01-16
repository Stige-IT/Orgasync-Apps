part of "../../project.dart";

class TaskDataModel {
  List<TaskItem>? done;
  List<TaskItem>? todo;
  List<TaskItem>? doing;

  TaskDataModel({this.done, this.todo, this.doing});

  TaskDataModel.fromJson(Map<String, dynamic> json) {
    if (json['done'] != null) {
      done = <TaskItem>[];
      json['done'].forEach((v) {
        done!.add(TaskItem.fromJson(v));
      });
    }
    if (json['todo'] != null) {
      todo = <TaskItem>[];
      json['todo'].forEach((v) {
        todo!.add(TaskItem.fromJson(v));
      });
    }
    if (json['doing'] != null) {
      doing = <TaskItem>[];
      json['doing'].forEach((v) {
        doing!.add(TaskItem.fromJson(v));
      });
    }
  }
}

class TaskItem {
  String? id;
  String? idProject;
  String? title;
  String? description;
  Status? status;
  Assignee? assignee;
  Priority? priority;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  EmployeeCompanyProject? createdBy;
  EmployeeCompanyProject? updatedBy;

  TaskItem({
    this.id,
    this.idProject,
    this.title,
    this.description,
    this.status,
    this.assignee,
    this.priority,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  TaskItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idProject = json['id_project'];
    title = json['title'];
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
    createdBy = json['created_by_employee'] != null
        ? EmployeeCompanyProject.fromJson(json['created_by_employee'])
        : null;
    updatedBy = json['updated_by_employee'] != null
        ? EmployeeCompanyProject.fromJson(json['updated_by_employee'])
        : null;
  }

  // to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id_project'] = idProject;
    data['title'] = title;
    data['description'] = description;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['status'] = status?.toJson();
    data['assignee'] = assignee?.toJson();
    data['priority'] = priority?.toJson();
    return data;
  }

  // to request
  Map<String, dynamic> toRequest() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['id_status'] = status?.id;
    data['id_priority'] = priority?.id;
    data['id_employee_company_project'] = assignee?.id;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    return data;
  }
}
