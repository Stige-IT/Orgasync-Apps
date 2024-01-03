part of "../../project.dart";

class Status {
  String? id;
  String? name;
  bool? isDone;

  Status({this.name, this.isDone, this.id});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isDone = json['is_done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['is_done'] = isDone;
    data['id'] = id;
    return data;
  }
}
