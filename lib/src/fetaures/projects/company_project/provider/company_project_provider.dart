part of "../../project.dart";

final imageProvider = StateProvider.autoDispose<File?>((ref) => null);

final employeProjectTempProvider = StateNotifierProvider.autoDispose<
    CandidateEmployeeProjectNotifier, List<Employee>>((ref) {
  return CandidateEmployeeProjectNotifier();
});

final companyProjectNotifier = StateNotifierProvider<CompanyProjectNotifier,
    BaseState<List<CompanyProject>>>((ref) {
  return CompanyProjectNotifier(ref.watch(companyProjectProvider));
});

// detail company porject
final detailCompanyProjectNotifier =
    StateNotifierProvider<DetailCompanyProjectNotifier, States<CompanyProject>>(
        (ref) {
  return DetailCompanyProjectNotifier(ref.watch(companyProjectProvider));
});

final totalCompanyProjectNotifier = StateNotifierProvider<
    CompanyProjectNotifier, BaseState<List<CompanyProject>>>((ref) {
  return CompanyProjectNotifier(ref.watch(companyProjectProvider));
});

// create company project
final createCompanyProjectNotifier =
    StateNotifierProvider<CreateCompanyProjectNotifier, States>((ref) {
  return CreateCompanyProjectNotifier(ref.watch(companyProjectProvider), ref);
});

// delete company project
final deleteCompanyProjectNotifier =
    StateNotifierProvider<DeleteCompanyProjectNotifier, States>((ref) {
  return DeleteCompanyProjectNotifier(ref.watch(companyProjectProvider), ref);
});
