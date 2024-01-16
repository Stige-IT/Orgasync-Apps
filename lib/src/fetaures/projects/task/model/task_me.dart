part of "../../project.dart";

class TaskMe {
  String? idCompanyProject;
  String? idProject;
  String? nameProject;
  String? descriptionProject;
  List<TaskItem>? task;

  TaskMe(
      {this.idCompanyProject,
      this.idProject,
      this.nameProject,
      this.descriptionProject,
      this.task});

  TaskMe.fromJson(Map<String, dynamic> json) {
    idCompanyProject = json['id_company_project'];
    idProject = json['id_project'];
    nameProject = json['name_project'];
    descriptionProject = json['description_project'];
    if (json['task'] != null) {
      task = <TaskItem>[];
      json['task'].forEach((v) {
        task!.add(TaskItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_company_project'] = idCompanyProject;
    data['id_project'] = idProject;
    data['name_project'] = nameProject;
    data['description_project'] = descriptionProject;
    if (task != null) {
      data['task'] = task!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
