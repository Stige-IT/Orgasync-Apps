class Address {
  String? id;
  String? street;
  AddressDetail? province;
  AddressDetail? regency;
  AddressDetail? district;
  AddressDetail? village;
  AddressDetail? country;
  int? zipCode;
  String? lat;
  String? lng;

  Address(
      {this.id,
      this.street,
      this.province,
      this.regency,
      this.district,
      this.village,
      this.country,
      this.zipCode,
      this.lat,
      this.lng});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    street = json['street'];
    province = json['province'] != null
        ? AddressDetail.fromJson(json['province'])
        : null;
    regency = json['regency'] != null
        ? AddressDetail.fromJson(json['regency'])
        : null;
    district = json['district'] != null
        ? AddressDetail.fromJson(json['district'])
        : null;
    village = json['village'] != null
        ? AddressDetail.fromJson(json['village'])
        : null;
    country = json['country'] != null
        ? AddressDetail.fromJson(json['country'])
        : null;
    zipCode = json['zip_code'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['street'] = street;
    if (province != null) {
      data['province'] = province!.toJson();
    }
    if (regency != null) {
      data['regency'] = regency!.toJson();
    }
    if (district != null) {
      data['district'] = district!.toJson();
    }
    if (village != null) {
      data['village'] = village!.toJson();
    }
    if (country != null) {
      data['country'] = country!.toJson();
    }
    data['zip_code'] = zipCode;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class AddressDetail {
  int? id;
  String? name;

  AddressDetail({this.id, this.name});

  AddressDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
