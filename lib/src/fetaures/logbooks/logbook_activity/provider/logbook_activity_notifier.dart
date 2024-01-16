part of "../logbook_activity.dart";

class LogBookActivityNotifier
    extends StateNotifier<States<List<LogBookActivity>>> {
  final LogBookActivityApi _api;
  LogBookActivityNotifier(this._api) : super(States.noState());

  Future<void> getLogBookActivity(String idLogBookEmployee) async {
    state = States.loading();
    try {
      final result = await _api.getLogBookActivity(idLogBookEmployee);
      result.fold(
        (error) => state = States.error(error),
        (data) => state = States.finished(data),
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
    }
  }
}

// get logbook activity me
class LogBookActivityMeNotifier
    extends StateNotifier<States<List<LogBookActivity>>> {
  final LogBookActivityApi _api;
  LogBookActivityMeNotifier(this._api) : super(States.noState());

  Future<void> getLogBookActivity(String idLogBook) async {
    state = States.loading();
    try {
      final result = await _api.getLogBookMeActivity(idLogBook);
      result.fold(
        (error) => state = States.error(error),
        (data) => state = States.finished(data),
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
    }
  }
}

// add logbook activity
class AddLogBookActivityNotifier extends StateNotifier<States> {
  final LogBookActivityApiImpl _api;
  final Ref ref;
  AddLogBookActivityNotifier(this._api, this.ref) : super(States.noState());

  Future<bool> add({
    String? idLogBookEmployee,
    required String idLogBook,
    required String description,
    required File? image,
    required int rating,
  }) async {
    Either<String, bool> result;
    state = States.loading();
    try {
      if (idLogBookEmployee != null) {
        result = await _api.addLogBookActivity(
          idLogBook: idLogBook,
          idLogBookEmployee: idLogBookEmployee,
          description: description,
          rating: rating,
          image: image,
        );
      } else {
        result = await _api.addLogBookActivityMe(
          idLogBook: idLogBook,
          description: description,
          rating: rating,
          image: image,
        );
      }
      result.fold(
        (error) => state = States.error(error),
        (success) {
          state = States.noState();
          if (idLogBookEmployee != null) {
            ref
                .read(logBookActivityNotifier.notifier)
                .getLogBookActivity(idLogBookEmployee);
          } else {
            ref
                .read(logBookActivityMeNotifier.notifier)
                .getLogBookActivity(idLogBook);
          }
        },
      );
      return result.isRight();
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
      return false;
    }
  }
}
