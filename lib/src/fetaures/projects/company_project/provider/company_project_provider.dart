part of "../../project.dart";

final companyProjectNotifier = StateNotifierProvider<CompanyProjectNotifier,
    BaseState<List<CompanyProject>>>((ref) {
  return CompanyProjectNotifier(ref.watch(companyProjectProvider));
});

final totalCompanyProjectNotifier = StateNotifierProvider<
    CompanyProjectNotifier, BaseState<List<CompanyProject>>>((ref) {
  return CompanyProjectNotifier(ref.watch(companyProjectProvider));
});
