part of "../user.dart";

class AddressRequest {
  String? street;
  int? province;
  int? regency;
  int? district;
  int? village;
  int? country;
  int? zipCode;
  String? lat;
  String? lng;

  AddressRequest(
      {this.street,
      this.province,
      this.regency,
      this.district,
      this.village,
      this.country,
      this.zipCode,
      this.lat,
      this.lng});

  AddressRequest.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    province = json['province'];
    regency = json['regency'];
    district = json['district'];
    village = json['village'];
    country = json['country'];
    zipCode = json['zip_code'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['province'] = province;
    data['regency'] = regency;
    data['district'] = district;
    data['village'] = village;
    data['country'] = country;
    data['zip_code'] = zipCode;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
