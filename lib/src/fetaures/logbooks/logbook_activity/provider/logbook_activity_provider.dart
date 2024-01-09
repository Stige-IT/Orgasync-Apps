part of "../logbook_activity.dart";

final selectedImageLogbookProvider =
    StateProvider.autoDispose<File?>((ref) => null);

final selectedRatingProvider = StateProvider.autoDispose<int>((ref) => 0);

final logBookActivityNotifier = StateNotifierProvider<LogBookActivityNotifier,
    States<List<LogBookActivity>>>((ref) {
  return LogBookActivityNotifier(ref.watch(logBookActivityProvider));
});

final logBookActivityMeNotifier = StateNotifierProvider<
    LogBookActivityMeNotifier, States<List<LogBookActivity>>>((ref) {
  return LogBookActivityMeNotifier(ref.watch(logBookActivityProvider));
});

final addLogBookActivityNotifier =
    StateNotifierProvider<AddLogBookActivityNotifier, States>((ref) {
  return AddLogBookActivityNotifier(ref.watch(logBookActivityProvider), ref);
});
