part of "../user.dart";

class UserData {
  String? id;
  String? name;
  String? image;
  String? email;
  bool? isActive;
  bool? isVerified;
  String? registeredAt;
  Address? address;

  UserData(
      {this.id,
        this.name,
        this.image,
        this.email,
        this.isActive,
        this.isVerified,
        this.registeredAt,
        this.address,
      });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    email = json['email'];
    isActive = json['is_active'];
    isVerified = json['is_verified'];
    registeredAt = json['registered_at'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
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
    return data;
  }
}
