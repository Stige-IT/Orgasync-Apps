part of "../logbook_employee.dart";

abstract class LogBookEmployeeApi {
  Future<Either<String, ResponseData<List<LogBookEmployee>>>>
      getLogBookEmployee(
    String idLogbook,
    int page,
  );
  Future<Either<String, bool>> createLogBookEmployee(
    List<String> idEmployee,
    String idLogBook,
  );
  Future<Either<String, bool>> deleteLogBookEmployee(
    List<String> idLogBookEmployee,
    String idLogBook,
  );
}

final logBookEmployeeProvider = Provider<LogBookEmployeeApiImpl>((ref) {
  return LogBookEmployeeApiImpl(ref.watch(httpRequestProvider));
});

class LogBookEmployeeApiImpl implements LogBookEmployeeApi {
  final HttpRequestClient _httpRequest;

  LogBookEmployeeApiImpl(this._httpRequest);

  @override
  Future<Either<String, ResponseData<List<LogBookEmployee>>>>
      getLogBookEmployee(String idLogbook, int page) async {
    final url =
        "${ConstantUrl.BASE_URL}/logbook/$idLogbook/employee?page=$page";
    final response = await _httpRequest.get(url);
    return response.fold(
      (error) => Left(error),
      (result) {
        List data = result['items'];
        final list = data.map((e) => LogBookEmployee.fromJson(e)).toList();
        return Right(ResponseData(
          data: list,
          total: result['total'],
          currentPage: result['page'],
          lastPage: result['pages'],
        ));
      },
    );
  }

  @override
  Future<Either<String, bool>> createLogBookEmployee(
    List<String> idEmployee,
    String idLogBook,
  ) async {
    final url = "${ConstantUrl.BASE_URL}/logbook/$idLogBook/employee";
    final response = await _httpRequest.post(url, body: {
      "id_employees": idEmployee,
    });
    return response.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }

  @override
  Future<Either<String, bool>> deleteLogBookEmployee(
    List<String> idLogBookEmployee,
    String idLogBook,
  ) async {
    final url = "${ConstantUrl.BASE_URL}/logbook/$idLogBook/employee";
    final response = await _httpRequest.delete(url, body: {
      "id_employees": idLogBookEmployee,
    });
    return response.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }
}
