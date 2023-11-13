part of "../auth.dart";

final isObsecureProvider = StateProvider.autoDispose<bool>((ref) => true);

/// state notifier
final loginNotifier =
    StateNotifierProvider.autoDispose<LoginNotifier, States>((ref) {
  final authApi = ref.watch(authProvider);
  return LoginNotifier(authApi);
});

final registerEmployeeNotifier =
    StateNotifierProvider.autoDispose<RegisterEmployeeNotifier, States>((ref) {
  final authApi = ref.watch(authProvider);
  return RegisterEmployeeNotifier(authApi);
});
