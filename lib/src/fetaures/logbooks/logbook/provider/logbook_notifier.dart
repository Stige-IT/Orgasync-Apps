part of "../logbook.dart";

class LogBookNotifier extends StateNotifier<BaseState<List<LogBook>>> {
  final LogBookApiImpl _api;
  LogBookNotifier(this._api) : super(const BaseState());

  Future<void> get(
    String idCompany, {
    int? page,
    bool? makeLoading = false,
    bool? isLoadMore = false,
  }) async {
    if (makeLoading!) {
      state = state.copyWith(isLoading: true);
    }

    try {
      final result =
          await _api.getLogBooks(idCompany, page: page ?? state.page);
      result.fold(
        (error) => state = state.copyWith(isLoading: false, error: error),
        (response) {
          if (isLoadMore!) {
            final data = [...state.data!, ...response.data!];
            state = state.copyWith(
              isLoading: false,
              error: null,
              data: data,
              page: response.currentPage!,
              lastPage: response.lastPage!,
            );
          } else {
            state = state.copyWith(
              isLoading: false,
              error: null,
              data: response.data,
              page: response.currentPage!,
              lastPage: response.lastPage!,
            );
          }
        },
      );
    } catch (exception) {
      state = state.copyWith(
        isLoading: false,
        error: exceptionTomessage(exception),
      );
    }
  }

  void isLoadMore(String idCompany) {
    state = state.copyWith(isLoadingMore: true, page: state.page + 1);
    get(idCompany, isLoadMore: true);
  }

  void refresh(String idCompany) {
    state = state.copyWith(isLoading: true, page: 1);
    get(idCompany);
  }
}

class DetailLogBookNotifier extends StateNotifier<States<LogBook>> {
  final LogBookApiImpl _api;
  DetailLogBookNotifier(this._api) : super(States.noState());

  Future<void> get(String idLogBook) async {
    state = States.loading();
    try {
      final result = await _api.getDetailLogBook(idLogBook);
      result.fold(
        (error) => state = States.error(error),
        (data) => state = States.finished(data),
      );
    } catch (e) {
      state = States.error(exceptionTomessage(e));
    }
  }
}

class AddLogBookNotifier extends StateNotifier<States> {
  final LogBookApiImpl _api;
  final Ref ref;
  AddLogBookNotifier(this._api, this.ref) : super(States.noState());

  Future<bool> addLogBook(LogBook logBook) async {
    final idCompany = ref.read(detailCompanyNotifier).data?.id;
    state = States.loading();
    try {
      final result = await _api.createLogBook(logBook, idCompany!);
      result.fold(
        (error) => state = States.error(error),
        (data) => state = States.noState(),
      );
      if (result.isRight()) {
        ref.watch(logBookNotifier.notifier).refresh(idCompany);
      }
      return result.isRight();
    } catch (e) {
      state = States.error(exceptionTomessage(e));
      return false;
    }
  }
}

class DeleteLogBookNotifier extends StateNotifier<States> {
  final LogBookApiImpl _api;
  final Ref ref;
  DeleteLogBookNotifier(this._api, this.ref) : super(States.noState());

  Future<bool> delete(String idLogbook) async {
    state = States.loading();
    try {
      final result = await _api.deleteLogBook(idLogbook);
      result.fold(
        (error) => state = States.error(error),
        (data) => state = States.noState(),
      );
      if (result.isRight()) {
        final idCompany = ref.read(detailCompanyNotifier).data?.id;
        ref.watch(logBookNotifier.notifier).refresh(idCompany!);
      }
      return result.isRight();
    } catch (e) {
      state = States.error(exceptionTomessage(e));
      return false;
    }
  }
}
