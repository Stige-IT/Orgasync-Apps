part of "../logbook_employee.dart";

// temporary state notifier for user when add employee
class CandidateLogBookEmployeeNotifier extends StateNotifier<List<Employee>> {
  CandidateLogBookEmployeeNotifier() : super([]);

  void add(Employee user) {
    if (state.contains(user)) return;
    state = [...state, user];
  }

  void remove(Employee user) {
    state = state.where((element) => element.id != user.id).toList();
  }

  void clear() {
    state = [];
  }
}

class SelectedLogBookEmployeeNotifier
    extends StateNotifier<List<LogBookEmployee>> {
  SelectedLogBookEmployeeNotifier() : super([]);

  void add(LogBookEmployee user) {
    if (state.contains(user)) return;
    state = [...state, user];
  }

  void remove(LogBookEmployee user) {
    state = state.where((element) => element.id != user.id).toList();
  }

  void clear() {
    state = [];
  }
}

class LogBookEmployeeNotifier
    extends StateNotifier<BaseState<List<LogBookEmployee>>> {
  final LogBookEmployeeApiImpl _api;
  LogBookEmployeeNotifier(this._api) : super(const BaseState());

  Future<void> getLogBookEmployee(String idLogbook,
      {int? page, bool? makeLoading = false, bool? isLoadMore = false}) async {
    if (makeLoading == true) {
      state = state.copyWith(isLoading: true);
    }
    try {
      final result =
          await _api.getLogBookEmployee(idLogbook, page ?? state.page);
      result.fold(
        (error) => state = state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          error: error,
        ),
        (response) {
          final data = response.data;
          if (isLoadMore!) {
            final list = [...state.data!, ...data!];
            state = state.copyWith(
              error: null,
              isLoading: false,
              isLoadingMore: false,
              data: list,
              page: response.currentPage!,
              lastPage: response.lastPage!,
            );
          } else {
            state = state.copyWith(
              error: null,
              isLoading: false,
              isLoadingMore: false,
              data: data,
              page: response.currentPage!,
              lastPage: response.lastPage!,
            );
          }
        },
      );
    } catch (exception) {
      state = state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          error: exceptionTomessage(exception));
    }
  }

  void isLoadMore(String idLogbook) {
    if (state.page < state.lastPage) {
      state = state.copyWith(page: state.page + 1);
      getLogBookEmployee(idLogbook, isLoadMore: true);
    }
  }

  void refresh(String idLogBook) {
    getLogBookEmployee(idLogBook, makeLoading: true);
  }
}

// add logbook employee
class AddLogBookEmployeeNotifier extends StateNotifier<States> {
  final LogBookEmployeeApiImpl _api;
  final Ref ref;
  AddLogBookEmployeeNotifier(this._api, this.ref) : super(States.noState());

  Future<bool> add(String idLogBook,
      {required List<String> idEmployees}) async {
    state = States.loading();
    try {
      final result = await _api.createLogBookEmployee(idEmployees, idLogBook);
      result.fold(
        (error) => state = States.error(error),
        (success) {
          state = States.noState();
          ref.read(logBookEmployeeNotifier.notifier).refresh(idLogBook);
        },
      );
      return result.isRight();
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
      return false;
    }
  }
}

// delete logbook employee
class DeleteLogBookEmployeeNotifier extends StateNotifier<States> {
  final LogBookEmployeeApiImpl _api;
  final Ref ref;
  DeleteLogBookEmployeeNotifier(this._api, this.ref) : super(States.noState());

  Future<bool> delete(String idLogBook,
      {required List<String> idLogBookEmployee}) async {
    state = States.loading();
    try {
      final result =
          await _api.deleteLogBookEmployee(idLogBookEmployee, idLogBook);
      result.fold(
        (error) => state = States.error(error),
        (success) {
          state = States.noState();
          ref.read(logBookEmployeeNotifier.notifier).refresh(idLogBook);
        },
      );
      return result.isRight();
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
      return false;
    }
  }
}
