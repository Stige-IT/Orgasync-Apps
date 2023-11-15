part of "../company.dart";

class MyCompany {
  String? id;
  String? joined;
  String? end;
  Position? position;
  Company? company;
  TypeEmployee? typeEmployee;

  MyCompany({this.id, this.joined, this.end, this.position, this.company});

  MyCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    joined = json['joined'];
    end = json['end'];
    position =
        json['position'] != null ? Position.fromJson(json['position']) : null;
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    typeEmployee =
        json['type'] != null ? TypeEmployee.fromJson(json['type']) : null;
  }

}
