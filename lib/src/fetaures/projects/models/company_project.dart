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

class DetailCompanyProject {
  CompanyProject? companyProject;
  int? totalEmployee;
  List<Employee>? employee;
  int? totalProject;
  List<Project>? project;

  DetailCompanyProject(
      {this.companyProject,
      this.totalEmployee,
      this.employee,
      this.totalProject,
      this.project});

  DetailCompanyProject.fromJson(Map<String, dynamic> json) {
    companyProject = json['company_project'] != null
        ? CompanyProject.fromJson(json['company_project'])
        : null;
    totalEmployee = json['total_employee'];
    if (json['employee'] != null) {
      employee = <Employee>[];
      json['employee'].forEach((v) {
        employee!.add(Employee.fromJson(v));
      });
    }
    totalProject = json['total_project'];
    if (json['project'] != null) {
      project = <Project>[];
      json['project'].forEach((v) {
        project!.add(Project.fromJson(v));
      });
    }
  }
}
