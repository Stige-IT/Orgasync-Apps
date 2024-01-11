part of "../../project.dart";

final titleIsUpdatedProvider = StateProvider.autoDispose<bool>((ref) => false);
final descriptionIsUpdatedProvider =
    StateProvider.autoDispose<bool>((ref) => false);

final selectedStatusProvider =
    StateProvider.autoDispose<Status?>((ref) => null);
final selectedAssignedProvider =
    StateProvider.autoDispose<EmployeeCompanyProject?>((ref) => null);

final selectedPriorityProvider =
    StateProvider.autoDispose<Priority?>((ref) => null);

final startDateProvider = StateProvider.autoDispose<String?>((ref) => null);
final endDateProvider = StateProvider.autoDispose<String?>((ref) => null);

final taskNotifier =
    StateNotifierProvider<TaskNotifier, BaseState<TaskDataModel>>((ref) {
  return TaskNotifier(ref.watch(taskProvider), ref);
});

final taskMeNotifier =
    StateNotifierProvider<TaskMeNotifier, States<List<TaskMe>>>((ref) {
  return TaskMeNotifier(ref.watch(taskProvider));
});

// get detail task by id
final detailTaskNotifier =
    StateNotifierProvider.autoDispose<DetailTaskNotifier, BaseState<TaskItem>>(
        (ref) {
  return DetailTaskNotifier(ref.watch(taskProvider));
});

// create new task
final addTaskNotifier = StateNotifierProvider<AddTaskNotifier, States>((ref) {
  return AddTaskNotifier(ref.watch(taskProvider), ref);
});

// update task
final updateTaskNotifier =
    StateNotifierProvider<UpdateTaskNotifier, States>((ref) {
  return UpdateTaskNotifier(ref.watch(taskProvider));
});

// delete task
final deleteTaskNotifier =
    StateNotifierProvider<DeleteTaskNotifier, States>((ref) {
  return DeleteTaskNotifier(ref.watch(taskProvider));
});
