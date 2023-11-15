part of "../company.dart";

class Company {
  String? id;
  String? email;
  String? logo;
  String? cover;
  String? code;
  String? name;
  String? type;
  int? size;
  Address? address;

  Company(
      {this.id,
      this.email,
      this.logo,
      this.cover,
      this.code,
      this.name,
      this.type,
      this.size,
      this.address});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    logo = json['logo'];
    cover = json['cover'];
    code = json['code'];
    name = json['name'];
    type = json['type'];
    size = json['size'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['logo'] = logo;
    data['cover'] = cover;
    data['code'] = code;
    data['name'] = name;
    data['type'] = type;
    data['size'] = size;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}
