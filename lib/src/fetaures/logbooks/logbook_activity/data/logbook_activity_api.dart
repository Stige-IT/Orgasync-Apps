part of "../logbook_activity.dart";

abstract class LogBookActivityApi {
  Future<Either<String, List<LogBookActivity>>> getLogBookActivity(
      String idLogBookEmployee);

  Future<Either<String, List<LogBookActivity>>> getLogBookMeActivity(
      String idLogBook);

  Future<Either<String, bool>> addLogBookActivity({
    required String idLogBook,
    required String idLogBookEmployee,
    required String description,
    File? image,
    required int rating,
  });

  Future<Either<String, bool>> addLogBookActivityMe({
    required String idLogBook,
    required String description,
    File? image,
    required int rating,
  });
}

final logBookActivityProvider = Provider<LogBookActivityApiImpl>((ref) {
  return LogBookActivityApiImpl(ref.watch(httpRequestProvider));
});

class LogBookActivityApiImpl implements LogBookActivityApi {
  final HttpRequestClient _httpRequest;

  LogBookActivityApiImpl(this._httpRequest);

  @override
  Future<Either<String, List<LogBookActivity>>> getLogBookActivity(
      String idLogBookEmployee) async {
    final url =
        "${ConstantUrl.BASE_URL}/logbook/employee/$idLogBookEmployee/activity";
    final response = await _httpRequest.get(url);
    return response.fold(
      (error) => Left(error),
      (result) {
        List data = result;
        final list = data.map((e) => LogBookActivity.fromJson(e)).toList();
        return Right(list);
      },
    );
  }

  @override
  Future<Either<String, List<LogBookActivity>>> getLogBookMeActivity(
      String idLogBook) async {
    final url =
        "${ConstantUrl.BASE_URL}/logbook/activity/me?id_logbook=$idLogBook";
    final response = await _httpRequest.get(url);
    return response.fold(
      (error) => Left(error),
      (result) {
        List data = result;
        final list = data.map((e) => LogBookActivity.fromJson(e)).toList();
        return Right(list);
      },
    );
  }

  @override
  Future<Either<String, bool>> addLogBookActivity({
    required String idLogBook,
    required String idLogBookEmployee,
    required String description,
    File? image,
    required int rating,
  }) async {
    final url =
        "${ConstantUrl.BASE_URL}/logbook/employee/$idLogBookEmployee/activity";
    final body = {
      "id_logbook": idLogBook,
      "description": description,
      "rating": rating.toString(),
    };
    final response = await _httpRequest.multipart(
      "POST",
      url,
      data: body,
      fieldFile: "image",
      file: image,
    );
    return response.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }

  @override
  Future<Either<String, bool>> addLogBookActivityMe({
    required String idLogBook,
    required String description,
    File? image,
    required int rating,
  }) async {
    const url = "${ConstantUrl.BASE_URL}/logbook/employee/activity/me";
    final body = {
      "id_logbook": idLogBook,
      "description": description,
      "rating": rating.toString(),
    };
    final response = await _httpRequest.multipart(
      "POST",
      url,
      data: body,
      fieldFile: "image",
      file: image,
    );
    return response.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }
}
