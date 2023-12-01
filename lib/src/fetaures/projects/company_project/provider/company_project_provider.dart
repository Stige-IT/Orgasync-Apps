part of "../../project.dart";

final companyProjectNotifier = StateNotifierProvider.autoDispose<
    CompanyProjectNotifier, BaseState<List<CompanyProject>>>((ref) {
  return CompanyProjectNotifier(ref.watch(companyProjectProvider));
});

final totalCompanyProjectNotifier = StateNotifierProvider.autoDispose<
    CompanyProjectNotifier, BaseState<List<CompanyProject>>>((ref) {
  return CompanyProjectNotifier(ref.watch(companyProjectProvider));
});
