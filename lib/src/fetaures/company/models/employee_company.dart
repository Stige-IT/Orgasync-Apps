part of "../company.dart";

class EmployeeCompany {
  String? id;
  String? joined;
  String? end;
  TypeEmployee? type;
  Position? position;
  UserData? user;

  EmployeeCompany(
      {this.id, this.joined, this.end, this.type, this.position, this.user});

  EmployeeCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    joined = json['joined'];
    end = json['end'];
    type = json['type'] != null ? TypeEmployee.fromJson(json['type']) : null;
    position =
        json['position'] != null ? Position.fromJson(json['position']) : null;
    user = json['user'] != null ? UserData.fromJson(json['user']) : null;
  }
}
