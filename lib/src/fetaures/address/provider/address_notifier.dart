part of "../address.dart";

class AddressNotifier extends StateNotifier<States<List<AddressDetail>>> {
  final AddressApiImpl addressApi;
  AddressNotifier(this.addressApi) : super(States.noState());

  Future<void> get({String title = "province", int? id}) async {
    state = States.loading();
    try {
      final result = await addressApi.getAddress(title: title, id: id);
      state = States.finished(result);
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
    }
  }
}
