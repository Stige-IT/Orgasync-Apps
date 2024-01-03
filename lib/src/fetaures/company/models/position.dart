part of "../company.dart";

class Position {
  final String? id;
  final String? name;

  Position({this.id, this.name});

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      id: json['id'],
      name: json['name'],
    );
  }
}
