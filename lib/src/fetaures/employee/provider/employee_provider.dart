part of "../employee.dart";

// employee company
final employeeCompanyNotifier = StateNotifierProvider.autoDispose<
    EmployeeCompanyNotifier, BaseState<List<Employee>>>((ref) {
  return EmployeeCompanyNotifier(ref.watch(employeeProvider));
});

// add employee
final addEmployeeNotifier =
    StateNotifierProvider.autoDispose<AddEmployeeNotifier, States>((ref) {
  return AddEmployeeNotifier(ref.watch(companyProvider), ref);
});

// delete employee
final deleteEmployeeNotifier =
    StateNotifierProvider<DeleteEmployeeNotifier, States>((ref) {
  return DeleteEmployeeNotifier(ref.watch(employeeProvider), ref);
});
