part of "../address.dart";

// state provider id addresses
final idProvinceProvider = StateProvider<int?>((ref) => null);
final idCityProvider = StateProvider<int?>((ref) => null);
final idDistrictProvider = StateProvider<int?>((ref) => null);
final idSubdistrictProvider = StateProvider<int?>((ref) => null);

// address province provider
final provinceNotifier =
    StateNotifierProvider<AddressNotifier, States<List<AddressDetail>>>((ref) {
  return AddressNotifier(ref.watch(addressProvider));
});

// address city provider
final cityNotifier =
    StateNotifierProvider<AddressNotifier, States<List<AddressDetail>>>((ref) {
  return AddressNotifier(ref.watch(addressProvider));
});

// address district provider
final districtNotifier =
    StateNotifierProvider<AddressNotifier, States<List<AddressDetail>>>((ref) {
  return AddressNotifier(ref.watch(addressProvider));
});

// address subdistrict provider
final subdistrictNotifier =
    StateNotifierProvider<AddressNotifier, States<List<AddressDetail>>>((ref) {
  return AddressNotifier(ref.watch(addressProvider));
});
