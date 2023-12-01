part of "../project.dart";

class CompanyProject {
  String? id;
  String? name;
  String? description;
  String? image;
  String? createdAt;

  CompanyProject(
      {this.id, this.name, this.description, this.image, this.createdAt});

  CompanyProject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['created_at'] = createdAt;
    return data;
  }
}
