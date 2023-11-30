part of "../user.dart";

final obsecureProvider = StateProvider<bool>((ref) => true);

final imageProvider = StateProvider.autoDispose<File?>((ref) => null);

final roleNotifier = StateNotifierProvider<RoleNotifier, TypeUser?>((ref) {
  return RoleNotifier(ref.watch(storageProvider), ref.watch(userProvider));
});

final userNotifier = StateNotifierProvider<UserNotifier, States<UserData>>(
  (ref) => UserNotifier(ref.watch(userProvider)),
);

final editUserNotifier =
    StateNotifierProvider<EditUserNotifier, States<bool>>((ref) {
  return EditUserNotifier(ref.watch(userProvider), ref);
});

// address provider
final addressNotifier =
    StateNotifierProvider<AddressNotifier, States<Address>>((ref) {
  return AddressNotifier(ref.watch(userProvider));
});

// edit address provider
final editAddressNotifier =
    StateNotifierProvider<EditAddressNotifier, States<bool>>((ref) {
  return EditAddressNotifier(ref.watch(userProvider), ref);
});

// edit password provider
final editPasswordNotifier =
    StateNotifierProvider<EditPasswordNotifier, States<bool>>((ref) {
  return EditPasswordNotifier(ref.watch(userProvider));
});
