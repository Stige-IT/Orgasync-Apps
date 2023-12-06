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

// add employee to company
class AddEmployeeNotifier extends StateNotifier<States> {
  final CompanyApiImpl _companyApiImpl;
  final Ref ref;
  AddEmployeeNotifier(this._companyApiImpl, this.ref) : super(States.noState());

  Future<bool> add(String companyId, {required List<UserData> users}) async {
    state = States.loading();
    List<String> emails = [];
    for (UserData user in users) {
      emails.add(user.email!);
    }
    try {
      final result =
          await _companyApiImpl.addEmployee(companyId, emails: emails);
      return result.fold((error) {
        state = States.error(error);
        return false;
      }, (success) {
        ref.read(employeeCompanyNotifier.notifier).refresh(companyId);
        state = States.noState();
        return true;
      });
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
      return false;
    }
  }
}

// state notifier for delete employee in company
class DeleteEmployeeNotifier extends StateNotifier<States> {
  final EmployeeApi _employeeApiImpl;
  final Ref ref;

  DeleteEmployeeNotifier(this._employeeApiImpl, this.ref)
      : super(States.noState());

  Future<bool> delete(String employeeId, String companyId) async {
    state = States.loading();
    try {
      final result = await _employeeApiImpl.deleteEmployee(employeeId);
      return result.fold((error) {
        state = States.error(error);
        return false;
      }, (success) {
        ref.read(employeeCompanyNotifier.notifier).getEmployee(companyId);
        state = States.noState();
        return true;
      });
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
      return false;
    }
  }
}
