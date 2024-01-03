part of "../company.dart";

class TypeCompany {
  String? name;
  String? id;

  TypeCompany({this.name, this.id});

  TypeCompany.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
