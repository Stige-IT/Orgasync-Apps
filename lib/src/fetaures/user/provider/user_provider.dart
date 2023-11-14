part of "../user.dart";

final roleNotifier = StateNotifierProvider<RoleNotifier, TypeUser?>((ref) {
  return RoleNotifier(ref.watch(storageProvider), ref.watch(userProvider));
});

final userNotifier = StateNotifierProvider<UserNotifier, States<UserData>>(
  (ref) => UserNotifier(ref.watch(userProvider)),
);
