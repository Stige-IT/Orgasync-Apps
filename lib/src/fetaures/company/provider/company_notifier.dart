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

// update company
class UpdateCompanyNotifier extends StateNotifier<States> {
  final CompanyApiImpl _companyApiImpl;
  final Ref ref;

  UpdateCompanyNotifier(this._companyApiImpl, this.ref)
      : super(States.noState());

  Future<bool> updateCompany(
    String companyId, {
    required String name,
    File? image,
    File? cover,
  }) async {
    state = States.loading();
    try {
      final result = await _companyApiImpl.updateCompany(
        companyId,
        name: name,
        image: image,
        cover: cover,
      );
      return result.fold((error) {
        state = States.error(error);
        return false;
      }, (success) {
        ref.read(detailCompanyNotifier.notifier).get(companyId);
        state = States.noState();
        return true;
      });
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
      return false;
    }
  }
}

// get detail company
class DetailCompanyNotifier extends StateNotifier<States<CompanyDetail>> {
  final CompanyApi _companyApi;
  DetailCompanyNotifier(this._companyApi) : super(States.noState());

  Future<void> get(String companyId) async {
    state = States.loading();
    try {
      final result = await _companyApi.getDetail(companyId);
      result.fold(
        (error) => state = States.error(error),
        (data) => state = States.finished(data),
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
    }
  }
}

// get total my company
class TotalMyCompanyNotifier extends StateNotifier<States> {
  final CompanyApiImpl _companyApiImpl;

  TotalMyCompanyNotifier(this._companyApiImpl) : super(States.noState());

  Future<void> getTotal() async {
    state = States.loading();
    try {
      final result = await _companyApiImpl.getCompany(1);
      result.fold(
        (error) => state = States.error(error),
        (response) => state = States.finished(null, total: response.total),
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
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

// leave company
class LeaveCompanyNotifier extends StateNotifier<States> {
  final CompanyApiImpl _companyApiImpl;
  final Ref ref;

  LeaveCompanyNotifier(this._companyApiImpl, this.ref)
      : super(States.noState());

  Future<bool> leaveCompany(String companyId) async {
    state = States.loading();
    try {
      final result = await _companyApiImpl.leaveCompany(companyId);
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

// create new company state notifier
class CreateCompanyNotifier extends StateNotifier<States> {
  final CompanyApiImpl _companyApiImpl;
  final Ref ref;

  CreateCompanyNotifier(this._companyApiImpl, this.ref)
      : super(States.noState());

  Future<bool> createCompany(CompanyRequest companyRequest) async {
    state = States.loading();
    try {
      final result = await _companyApiImpl.createCompany(companyRequest);
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

// check role in company
class RoleInCompanyNotifier extends StateNotifier<States<Role>> {
  final CompanyApiImpl _companyApiImpl;
  RoleInCompanyNotifier(this._companyApiImpl) : super(States.noState());

  Future<void> check(String companyId) async {
    state = States.loading();
    try {
      final result = await _companyApiImpl.checkRoleInCompany(companyId);
      result.fold(
        (error) => state = States.error(error),
        (data) => state = States.finished(_parseRole(data)),
      );
      log(state.data.toString());
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
    }
  }

  Role _parseRole(String role) {
    print("🧑 $role");
    switch (role) {
      case "owner":
        return Role.owner;
      case "admin":
        return Role.admin;
      case "guest":
        return Role.guest;
      default:
        return Role.member;
    }
  }
}

// delete company
class DeleteCompanyNotifier extends StateNotifier<States> {
  final CompanyApiImpl _companyApiImpl;
  final Ref ref;

  DeleteCompanyNotifier(this._companyApiImpl, this.ref)
      : super(States.noState());

  Future<bool> delete(String companyId) async {
    state = States.loading();
    try {
      final result = await _companyApiImpl.deleteCompany(companyId);
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
