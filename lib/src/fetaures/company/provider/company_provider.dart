part of "../company.dart";

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

// create new company
final createCompanyNotifier =
    StateNotifierProvider.autoDispose<CreateCompanyNotifier, States>((ref) {
  return CreateCompanyNotifier(ref.watch(companyProvider), ref);
});
