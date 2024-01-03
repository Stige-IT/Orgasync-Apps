part of "../../project.dart";

class PriorityNotifier extends StateNotifier<States<List<Priority>>> {
  final PriorityApiImpl _priorityApiImpl;
  PriorityNotifier(this._priorityApiImpl) : super(States.noState());

  void getPriorities() async {
    state = States.loading();
    try {
      final response = await _priorityApiImpl.getPriorities();
      response.fold(
        (error) => state = States.error(error),
        (data) => state = States.finished(data),
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
    }
  }
}
