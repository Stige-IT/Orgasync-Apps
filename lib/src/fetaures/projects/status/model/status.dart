part of "../../project.dart";

class Status {
  String? id;
  String? name;
  int? level;
  String? color;

  Status({this.name, this.level, this.id, this.color});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    level = json['level'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['level'] = level;
    data['id'] = id;
    data['color'] = color;
    return data;
  }
}
