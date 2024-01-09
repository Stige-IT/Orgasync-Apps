part of "../logbook.dart";

final selectedStartDateProvider =
    StateProvider.autoDispose<DateTime?>((ref) => null);
final selectedEndDateProvider =
    StateProvider.autoDispose<DateTime?>((ref) => null);

final logBookNotifier =
    StateNotifierProvider<LogBookNotifier, BaseState<List<LogBook>>>((ref) {
  return LogBookNotifier(ref.watch(logBookProvider));
});

final detailLogBookNotifier =
    StateNotifierProvider<DetailLogBookNotifier, States<LogBook>>((ref) {
  return DetailLogBookNotifier(ref.watch(logBookProvider));
});

final addLogBookNotifier =
    StateNotifierProvider<AddLogBookNotifier, States>((ref) {
  return AddLogBookNotifier(ref.watch(logBookProvider), ref);
});

final deleteLogBookNotifier =
    StateNotifierProvider<DeleteLogBookNotifier, States>((ref) {
  return DeleteLogBookNotifier(ref.watch(logBookProvider), ref);
});
