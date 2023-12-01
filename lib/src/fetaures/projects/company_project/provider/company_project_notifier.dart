part of "../../project.dart";

class CompanyProjectNotifier
    extends StateNotifier<BaseState<List<CompanyProject>>> {
  final CompanyProjectImpl _projectImpl;
  CompanyProjectNotifier(this._projectImpl) : super(const BaseState());

  Future<void> get(
    String companyId, {
    int? page,
    bool? makeLoading = false,
    bool? isLoadMore = false,
  }) async {
    if (makeLoading!) {
      state = const BaseState(isLoading: true);
    }
    try {
      final result =
          await _projectImpl.getProjects(companyId, page: page ?? state.page);
      result.fold(
        (error) => state = state.copyWith(
            error: error, isLoading: false, isLoadingMore: false),
        (response) => state = state.copyWith(
          data:
              isLoadMore! ? [...state.data!, ...response.data!] : response.data,
          page: response.currentPage!,
          lastPage: response.lastPage!,
          total: response.total!,
          isLoading: false,
          isLoadingMore: false,
          error: null,
        ),
      );
    } catch (exception) {
      state = state.copyWith(
          error: exceptionTomessage(exception),
          isLoading: false,
          isLoadingMore: false);
    }
  }

  void loadMore(String companyId) async {
    state = state.copyWith(page: state.page + 1);
    get(companyId, isLoadMore: true);
  }

  void refresh(String companyId) => get(companyId, page: 1, makeLoading: true);
}
