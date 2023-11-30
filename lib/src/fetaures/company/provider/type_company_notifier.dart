part of "../company.dart";

class TypeNotifier extends StateNotifier<States<List<TypeCompany>>> {
  final TypeCompanyApi _typeCompanyApi;
  TypeNotifier(this._typeCompanyApi) : super(States.noState());

  Future<void> getTypeCompany() async {
    state = States.loading();
    try {
      final result = await _typeCompanyApi.getTypeCompany();
      result.fold(
        (error) => state = States.error(error),
        (data) => state = States.finished(data),
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
    }
  }
}
