part of "../../project.dart";

class StatusNotifier extends StateNotifier<States<List<Status>>> {
  final StatusApi statusApi;
  StatusNotifier(this.statusApi) : super(States.noState());

  Future<void> getStatus() async {
    state = States.loading();
    try {
      final response = await statusApi.getStatus();
      response.fold(
        (error) => state = States.error(error),
        (data) => state = States.finished(data),
      );
    } catch (e) {
      state = States.error(exceptionTomessage(e));
    }
  }
}
