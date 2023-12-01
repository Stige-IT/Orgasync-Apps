part of "../employee.dart";

// state notifier for get employee company
class EmployeeCompanyNotifier extends StateNotifier<BaseState<List<Employee>>> {
  final EmployeeApi _employeeApi;

  EmployeeCompanyNotifier(this._employeeApi) : super(const BaseState());

  Future<void> getEmployee(String companyId,
      {bool? makeLoading = false, bool? isLoadMore = false}) async {
    if (makeLoading!) {
      state = state.copyWith(isLoading: true);
    }
    try {
      final result =
          await _employeeApi.getEmployeeCompany(companyId, page: state.page);
      result.fold(
        (error) => state = state.copyWith(
            isLoading: false, isLoadingMore: false, error: error),
        (response) => state = state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          error: null,
          data:
              isLoadMore! ? [...state.data!, ...response.data!] : response.data,
          total: response.total!,
          lastPage: response.lastPage!,
          page: response.currentPage!,
        ),
      );
    } catch (exception) {
      state = state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          error: exceptionTomessage(exception));
    }
  }

  Future<void> refresh(String companyId) async {
    state = state.copyWith(page: 1);
    await getEmployee(companyId, makeLoading: true);
  }

  Future<void> loadMore(String companyId) async {
    if (state.page < state.lastPage) {
      state = state.copyWith(page: state.page + 1, isLoadingMore: true);
      await getEmployee(companyId, isLoadMore: true);
    }
  }
}
