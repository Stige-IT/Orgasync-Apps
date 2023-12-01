part of "../employee.dart";

// employee company
final employeeCompanyNotifier = StateNotifierProvider.autoDispose<
    EmployeeCompanyNotifier, BaseState<List<Employee>>>((ref) {
  return EmployeeCompanyNotifier(ref.watch(employeeProvider));
});
