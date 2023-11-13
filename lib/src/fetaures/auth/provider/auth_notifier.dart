part of "../auth.dart";

class LoginNotifier extends StateNotifier<States> {
  final AuthApi _authApi;

  LoginNotifier(this._authApi) : super(States.noState());

  Future<bool> login(String email, String password) async {
    state = States.loading();
    try {
      final result = await _authApi.login(email, password);
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
