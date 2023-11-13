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
