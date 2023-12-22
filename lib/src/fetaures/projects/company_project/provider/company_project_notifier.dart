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

// detail company project with States<CompanyProject>
class DetailCompanyProjectNotifier
    extends StateNotifier<States<DetailCompanyProject>> {
  final CompanyProjectImpl _projectImpl;
  DetailCompanyProjectNotifier(this._projectImpl) : super(States.noState());

  Future<void> get(String id) async {
    state = States.loading();
    try {
      final result = await _projectImpl.detailCompanyProject(id);
      result.fold(
        (error) => state = States.error(error),
        (response) => state = States.finished(response),
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
    }
  }
}

// create company project
class CreateCompanyProjectNotifier extends StateNotifier<States> {
  final CompanyProjectImpl _projectImpl;
  final Ref ref;
  CreateCompanyProjectNotifier(this._projectImpl, this.ref)
      : super(States.noState());

  Future<bool> create(
    String companyId, {
    required String name,
    required String description,
    File? image,
  }) async {
    state = States.loading();
    try {
      final result = await _projectImpl.createCompanyProject(
        companyId,
        name: name,
        description: description,
        image: image,
      );
      return result.fold(
        (error) {
          state = States.error(error);
          return false;
        },
        (response) {
          state = States.noState();
          ref.read(companyProjectNotifier.notifier).refresh(companyId);
          return true;
        },
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
      return false;
    }
  }
}

// delete company project
class DeleteCompanyProjectNotifier extends StateNotifier<States> {
  final CompanyProjectImpl _projectImpl;
  final Ref ref;
  DeleteCompanyProjectNotifier(this._projectImpl, this.ref)
      : super(States.noState());

  Future<bool> delete(String companyId, String id) async {
    state = States.loading();
    try {
      final result = await _projectImpl.deleteCompanyProject(id);
      return result.fold(
        (error) {
          state = States.error(error);
          return false;
        },
        (response) {
          state = States.noState();
          ref.read(companyProjectNotifier.notifier).refresh(companyId);
          return true;
        },
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
      return false;
    }
  }
}

// temporary state notifier for user when add employee
class CandidateEmployeeProjectNotifier extends StateNotifier<List<Employee>> {
  CandidateEmployeeProjectNotifier() : super([]);

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
