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

// type employee
final typeEmployeeNotifier =
    StateNotifierProvider<TypeEmployeeNotifier, States<List<TypeEmployee>>>(
        (ref) {
  return TypeEmployeeNotifier(ref.watch(employeeProvider));
});

// create type employee
final createTypeEmployeeNotifier =
    StateNotifierProvider.autoDispose<CreateTypeEmployeeNotifier, States>(
        (ref) {
  return CreateTypeEmployeeNotifier(ref.watch(employeeProvider), ref);
});

// update type employee
final updateTypeEmployeeNotifier =
    StateNotifierProvider.autoDispose<UpdateTypeEmployeeNotifier, States>(
        (ref) {
  return UpdateTypeEmployeeNotifier(ref.watch(employeeProvider), ref);
});
