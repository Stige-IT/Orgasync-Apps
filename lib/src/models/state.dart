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
