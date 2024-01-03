import 'package:freezed_annotation/freezed_annotation.dart';

part "state.freezed.dart";

@freezed
class BaseState<T> with _$BaseState<T> {
  const factory BaseState({
    @Default(false) isLoading,
    @Default(false) isLoadingMore,
    String? error,
    T? data,
    @Default(1) int page,
    @Default(1) int lastPage,
    @Default(0) int total,
  }) = _BaseState;
}


class States<T> {
  final T? data;
  final int? total;
  final String? error;
  final bool isLoading;

  States({
    this.data,
    this.total = 0,
    this.error,
    required this.isLoading,
  });

  factory States.noState() => States(isLoading: false);

  factory States.loading() => States(isLoading: true);

  factory States.error(String error) => States(isLoading: false, error: error);

  factory States.finished(T data, {int? total = 0}) =>
      States(isLoading: false, data: data, total: total);
}
