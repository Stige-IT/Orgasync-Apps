part of "../company.dart";

final companyNotifier = StateNotifierProvider<CompanyNotifier, BaseState<List<MyCompany>>>((ref) {
  return CompanyNotifier(ref.watch(companyProvider));
});

final joinCompanyNotifier = StateNotifierProvider<JoinCompanyNotifier, States>((ref) {
  return JoinCompanyNotifier(ref.watch(companyProvider), ref);
});