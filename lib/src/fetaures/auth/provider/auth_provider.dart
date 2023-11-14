part of "../auth.dart";

final isObsecureProvider = StateProvider.autoDispose<bool>((ref) => true);
// type company
final typeCompanyProvider = StateProvider.autoDispose<String?>((ref) => null);


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

final registerCompanyNotifier =
    StateNotifierProvider.autoDispose<RegisterCompanyNotifier, States>((ref) {
  final authApi = ref.watch(authProvider);
  return RegisterCompanyNotifier(authApi);
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