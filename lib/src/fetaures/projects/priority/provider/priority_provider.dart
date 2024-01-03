part of "../../project.dart";

final priorityNotifier =
    StateNotifierProvider<PriorityNotifier, States<List<Priority>>>((ref) {
  return PriorityNotifier(ref.watch(priorityProvider));
});
