part of "../company.dart";

class CompanyDetail {
  String? id;
  String? name;
  String? description;
  String? logo;
  String? cover;
  String? code;
  int? size;
  Owner? owner;
  TypeCompany? typeCompany;
  Address? address;

  CompanyDetail(
      {this.id,
      this.name,
      this.description,
      this.logo,
      this.cover,
      this.code,
      this.size,
      this.owner,
      this.typeCompany,
      this.address});

  CompanyDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    logo = json['logo'];
    cover = json['cover'];
    code = json['code'];
    size = json['size'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    typeCompany = json['type_company'] != null
        ? TypeCompany.fromJson(json['type_company'])
        : null;
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['logo'] = logo;
    data['cover'] = cover;
    data['code'] = code;
    data['size'] = size;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    if (typeCompany != null) {
      data['type_company'] = typeCompany!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}

class Owner {
  String? id;
  String? name;
  String? image;
  String? email;

  Owner({this.id, this.name, this.image, this.email});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['email'] = email;
    return data;
  }
}
