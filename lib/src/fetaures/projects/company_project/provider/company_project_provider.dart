part of "../../project.dart";

final imageProvider = StateProvider.autoDispose<File?>((ref) => null);

final companyProjectNotifier = StateNotifierProvider<CompanyProjectNotifier,
    BaseState<List<CompanyProject>>>((ref) {
  return CompanyProjectNotifier(ref.watch(companyProjectProvider));
});

// detail company porject
final detailCompanyProjectNotifier = StateNotifierProvider<
    DetailCompanyProjectNotifier, States<DetailCompanyProject>>((ref) {
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

final employeProjectTempProvider = StateNotifierProvider.autoDispose<
    CandidateEmployeeProjectNotifier, List<Employee>>((ref) {
  return CandidateEmployeeProjectNotifier();
});

// member company project
final memberCompanyProjectNotifier = StateNotifierProvider<
    MemberCompanyProjectNotifier,
    BaseState<List<EmployeeCompanyProject>>>((ref) {
  return MemberCompanyProjectNotifier(ref.watch(companyProjectProvider), ref);
});

// add member to company project
final addMemberToCompanyProjectNotifier =
    StateNotifierProvider<AddMemberToCompanyProjectNotifier, States>((ref) {
  return AddMemberToCompanyProjectNotifier(
      ref.watch(companyProjectProvider), ref);
});

// remove member from company project
final removeMemberFromCompanyProjectNotifier =
    StateNotifierProvider<RemoveMemberFromCompanyProjectNotifier, States>(
        (ref) {
  return RemoveMemberFromCompanyProjectNotifier(
      ref.watch(companyProjectProvider), ref);
});
