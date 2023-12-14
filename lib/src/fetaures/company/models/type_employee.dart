part of "../company.dart";

class TypeEmployee {
  final String? id;
  final String? name;
  final int? level;

  TypeEmployee({this.id, this.name, this.level});

  factory TypeEmployee.fromJson(Map<String, dynamic> json) {
    return TypeEmployee(
      id: json['id'],
      name: json['name'],
      level: json['level'],
    );
  }
}
