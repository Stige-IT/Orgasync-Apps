part of "../project.dart";

class Project {
  String? id;
  String? name;
  String? description;
  int? totalTask;
  int? done;
  int? undone;
  double? percentase;
  String? createdAt;

  Project({
    this.id,
    this.name,
    this.description,
    this.totalTask,
    this.done,
    this.undone,
    this.percentase,
    this.createdAt,
  });

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    totalTask = json['total_task'];
    done = json['done'];
    undone = json['undone'];
    percentase = json['percentase'];
    createdAt = json['created_at'];
  }
}
