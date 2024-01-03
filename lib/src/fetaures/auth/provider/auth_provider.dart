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

final verificationNotifier =
    StateNotifierProvider.autoDispose<VerificationNotifier, States>((ref) {
  final authApi = ref.watch(authProvider);
  return VerificationNotifier(authApi);
});

final resendCodeNotifier =
    StateNotifierProvider<ResendCodeNotifier, States>((ref) {
  final authApi = ref.watch(authProvider);
  return ResendCodeNotifier(authApi);
});

final refreshNotifier =
    StateNotifierProvider<RefreshTokenNotifier, States>((ref) {
  return RefreshTokenNotifier(ref.watch(authProvider));
});
