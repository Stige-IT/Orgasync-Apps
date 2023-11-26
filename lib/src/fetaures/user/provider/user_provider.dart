part of "../user.dart";

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