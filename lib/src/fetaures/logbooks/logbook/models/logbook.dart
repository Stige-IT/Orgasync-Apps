import '../../../../models/address.dart';
import '../../../company/company.dart';

class LogBook {
  String? id;
  String? name;
  String? description;
  String? periodeStart;
  String? periodeEnd;
  String? createdAt;
  Company? company;

  LogBook(
      {this.id,
      this.name,
      this.description,
      this.periodeStart,
      this.periodeEnd,
      this.createdAt,
      this.company});

  LogBook.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    periodeStart = json['periode_start'];
    periodeEnd = json['periode_end'];
    createdAt = json['created_at'];
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['periode_start'] = periodeStart;
    data['periode_end'] = periodeEnd;
    data['created_at'] = createdAt;
    if (company != null) {
      data['company'] = company!.toJson();
    }
    return data;
  }
}

class Owner {
  String? id;
  String? name;
  String? image;
  String? email;
  bool? isActive;
  bool? isVerified;
  String? registeredAt;
  Address? address;

  Owner(
      {this.id,
      this.name,
      this.image,
      this.email,
      this.isActive,
      this.isVerified,
      this.registeredAt,
      this.address});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    email = json['email'];
    isActive = json['is_active'];
    isVerified = json['is_verified'];
    registeredAt = json['registered_at'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['email'] = email;
    data['is_active'] = isActive;
    data['is_verified'] = isVerified;
    data['registered_at'] = registeredAt;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}
