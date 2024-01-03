part of "../project.dart";

class EmployeeCompanyProject {
  final String? id;
  final Employee? employee;

  EmployeeCompanyProject({this.id, this.employee});

  factory EmployeeCompanyProject.fromJson(Map<String, dynamic> json) {
    return EmployeeCompanyProject(
      id: json['id'],
      employee:
          json['employee'] != null ? Employee.fromJson(json['employee']) : null,
    );
  }
}
