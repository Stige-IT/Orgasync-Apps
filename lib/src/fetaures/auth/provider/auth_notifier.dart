part of "../auth.dart";

class LoginNotifier extends StateNotifier<States> {
  final AuthApi _authApi;

  LoginNotifier(this._authApi) : super(States.noState());

  Future<TypeAccount> login(String email, String password) async {
    state = States.loading();
    try {
      final result = await _authApi.login(email, password);
      return result.fold(
        (error) {
          state = States.error(error.message);
          return error.typeAccount;
        },
        (success) {
          state = States.noState();
          return success;
        },
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
      return TypeAccount.error;
    }
  }
}

// register user employee
class RegisterEmployeeNotifier extends StateNotifier<States> {
  final AuthApi _authApi;

  RegisterEmployeeNotifier(this._authApi) : super(States.noState());

  Future<bool> register(
      {required String name,
      required String email,
      required String password}) async {
    state = States.loading();
    try {
      final result =
          await _authApi.register(name: name, email: email, password: password);
      return result.fold(
        (error) {
          state = States.error(error);
          return false;
        },
        (success) {
          state = States.noState();
          return true;
        },
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
      return false;
    }
  }
}

// register user company
class RegisterCompanyNotifier extends StateNotifier<States> {
  final AuthApi _authApi;

  RegisterCompanyNotifier(this._authApi) : super(States.noState());

  Future<bool> register(CompanyRequest companyRequest) async {
    state = States.loading();
    try {
      final result = await _authApi.companyRegister(companyRequest);
      return result.fold(
        (error) {
          state = States.error(error);
          return false;
        },
        (success) {
          state = States.noState();
          return true;
        },
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
      return false;
    }
  }
}

// verification user
class VerificationNotifier extends StateNotifier<States> {
  final AuthApi _authApi;

  VerificationNotifier(this._authApi) : super(States.noState());

  Future<bool> verification(
      {required String email,
      required String code,
      required TypeVerification type}) async {
    state = States.loading();
    try {
      final result = await _authApi.verification(
        email: email,
        code: code,
        type: type,
      );
      return result.fold(
        (error) {
          state = States.error(error);
          return false;
        },
        (success) {
          state = States.noState();
          return true;
        },
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
      return false;
    }
  }
}

// resend code
class ResendCodeNotifier extends StateNotifier<States> {
  final AuthApi _authApi;

  ResendCodeNotifier(this._authApi) : super(States.noState());

  Future<bool> resendCode(String email) async {
    state = States.loading();
    try {
      final result = await _authApi.resendCode(email);
      return result.fold(
        (error) {
          state = States.error(error);
          return false;
        },
        (success) {
          state = States.noState();
          return true;
        },
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
      return false;
    }
  }
}

// refresh token
class RefreshTokenNotifier extends StateNotifier<States> {
  final AuthApiImpl authApiImpl;

  RefreshTokenNotifier(this.authApiImpl) : super(States.noState());

  void refresh() async {
    try {
      final result = await authApiImpl.refreshToken();
      result.fold(
        (error) => state = States.error(error),
        (success) => state = States.noState(),
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
    }
  }
}
