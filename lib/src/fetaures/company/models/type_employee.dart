part of "../company.dart";

class TypeEmployee{
  final String? id;
  final String? name;

  TypeEmployee({this.id, this.name});

  factory TypeEmployee.fromJson(Map<String, dynamic> json) {
    return TypeEmployee(
      id: json['id'],
      name: json['name'],
    );
  }
}