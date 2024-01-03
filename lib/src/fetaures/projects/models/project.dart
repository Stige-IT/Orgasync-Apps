part of "../project.dart";

class Project {
  String? id;
  String? name;
  String? description;
  String? createdAt;

  Project({this.id, this.name, this.description, this.createdAt});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
  }
}
