part of "../../project.dart";

class Priority {
  String? id;
  String? name;
  int? level;

  Priority({this.id, this.name, this.level});

  Priority.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['level'] = level;
    return data;
  }
}