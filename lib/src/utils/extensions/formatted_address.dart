
import '../../models/address.dart';

extension FormattedAddress on Address {
  String get formattedAddress {
    final String street = this.street ?? "";
    final String village = this.village?.name ?? "";
    final String district = this.district?.name ?? "";
    final String regency = this.regency?.name ?? "";
    final String province = this.province?.name ?? "";
    final String country = this.country?.name ?? "";
    final int? zip = zipCode;

    final String address = '$street $village $district $regency $province $country ${zip ?? ""}';
    return address;
  }
}