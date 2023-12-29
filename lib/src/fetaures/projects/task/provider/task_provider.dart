part of "../../project.dart";

final taskNotifier =
    StateNotifierProvider<TaskNotifier, BaseState<TaskDataModel>>((ref) {
  return TaskNotifier(ref.watch(taskProvider), ref);
});

// update task
final updateTaskNotifier =
    StateNotifierProvider<UpdateTaskNotifier, States>((ref) {
  return UpdateTaskNotifier(ref.watch(taskProvider));
});
