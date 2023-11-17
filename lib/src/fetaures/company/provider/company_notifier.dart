part of "../company.dart";

// state notifier for get company
class CompanyNotifier extends StateNotifier<BaseState<List<MyCompany>>> {
  final CompanyApiImpl _companyApiImpl;

  CompanyNotifier(this._companyApiImpl) : super(const BaseState());

  Future<void> getCompany({
    bool? makeLoading = false,
    bool? isLoadMore = false,
  }) async {
    if (makeLoading!) {
      state = state.copyWith(isLoading: true);
    }
    try {
      final result = await _companyApiImpl.getCompany(state.page);
      result.fold(
          (error) => state = state.copyWith(
              isLoading: false, isLoadingMore: false, error: error),
          (response) => state = state.copyWith(
                isLoading: false,
                isLoadingMore: false,
                error: null,
                data: isLoadMore!
                    ? [...state.data!, ...response.data!]
                    : response.data,
                total: response.total!,
                lastPage: response.lastPage!,
                page: response.currentPage!,
              ));
    } catch (exception) {
      state = state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          error: exceptionTomessage(exception));
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(page: 1);
    await getCompany(makeLoading: true);
  }

  Future<void> loadMore() async {
    if (state.page < state.lastPage) {
      state = state.copyWith(page: state.page + 1, isLoadingMore: true);
      await getCompany(isLoadMore: true);
    }
  }
}

// state notifier for join company
class JoinCompanyNotifier extends StateNotifier<States> {
  final CompanyApiImpl _companyApiImpl;
  final Ref ref;

  JoinCompanyNotifier(this._companyApiImpl, this.ref) : super(States.noState());

  Future<bool> joinCompany(String code) async {
    state = States.loading();
    try {
      final result = await _companyApiImpl.joinCompany(code);
      return result.fold((error) {
        state = States.error(error);
        return false;
      }, (success) {
        ref.read(companyNotifier.notifier).refresh();
        state = States.noState();
        return true;
      });
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
      return false;
    }
  }
}
