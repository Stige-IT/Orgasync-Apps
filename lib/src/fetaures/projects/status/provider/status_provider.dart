part of "../../project.dart";

final statusNotifier =
    StateNotifierProvider<StatusNotifier, States<List<Status>>>((ref) {
  return StatusNotifier(ref.watch(statusProvider));
});
