part of "../logbook_employee.dart";

final selectedlogBookEmployeeProvider = StateNotifierProvider.autoDispose<
    SelectedLogBookEmployeeNotifier, List<LogBookEmployee>>((ref) {
  return SelectedLogBookEmployeeNotifier();
});

final logBookEmployeeTempProvider = StateNotifierProvider.autoDispose<
    CandidateLogBookEmployeeNotifier, List<Employee>>((ref) {
  return CandidateLogBookEmployeeNotifier();
});

final logBookEmployeeNotifier = StateNotifierProvider<LogBookEmployeeNotifier,
    BaseState<List<LogBookEmployee>>>((ref) {
  return LogBookEmployeeNotifier(ref.watch(logBookEmployeeProvider));
});

final addLogBookEmployeeNotifier =
    StateNotifierProvider<AddLogBookEmployeeNotifier, States>((ref) {
  return AddLogBookEmployeeNotifier(ref.watch(logBookEmployeeProvider), ref);
});

final removeLogBookEmployeeNotifier =
    StateNotifierProvider<DeleteLogBookEmployeeNotifier, States>((ref) {
  return DeleteLogBookEmployeeNotifier(ref.watch(logBookEmployeeProvider), ref);
});
