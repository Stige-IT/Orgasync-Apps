part of "../company.dart";

final logoCompanyProvider = StateProvider.autoDispose<File?>((ref) => null);
final coverCompanyProvider = StateProvider.autoDispose<File?>((ref) => null);

// index of stack screen
final indexScreenProvider = StateProvider<int>((ref) => 0);

// type company
final typeCompanyNotifier = StateProvider.autoDispose<String?>((ref) => null);

final companyNotifier = StateNotifierProvider.autoDispose<CompanyNotifier,
    BaseState<List<MyCompany>>>((ref) {
  return CompanyNotifier(ref.watch(companyProvider));
});

final detailCompanyNotifier = StateNotifierProvider.autoDispose<
    DetailCompanyNotifier, States<CompanyDetail>>((ref) {
  return DetailCompanyNotifier(ref.watch(companyProvider));
});

final totalMyCompanyNotifier =
    StateNotifierProvider.autoDispose<TotalMyCompanyNotifier, States>((ref) {
  return TotalMyCompanyNotifier(ref.watch(companyProvider));
});

final joinCompanyNotifier =
    StateNotifierProvider.autoDispose<JoinCompanyNotifier, States>((ref) {
  return JoinCompanyNotifier(ref.watch(companyProvider), ref);
});

// leave company
final leaveCompanyNotifier =
    StateNotifierProvider<LeaveCompanyNotifier, States>((ref) {
  return LeaveCompanyNotifier(ref.watch(companyProvider), ref);
});

// create new company
final createCompanyNotifier =
    StateNotifierProvider.autoDispose<CreateCompanyNotifier, States>((ref) {
  return CreateCompanyNotifier(ref.watch(companyProvider), ref);
});

// update company
final updateCompanyNotifier =
    StateNotifierProvider<UpdateCompanyNotifier, States>((ref) {
  return UpdateCompanyNotifier(ref.watch(companyProvider), ref);
});

// check role in company
final roleInCompanyNotifier =
    StateNotifierProvider<RoleInCompanyNotifier, States<Role>>((ref) {
  return RoleInCompanyNotifier(ref.watch(companyProvider));
});

// delete company
final deleteCompanyNotifier =
    StateNotifierProvider<DeleteCompanyNotifier, States>((ref) {
  return DeleteCompanyNotifier(ref.watch(companyProvider), ref);
});
