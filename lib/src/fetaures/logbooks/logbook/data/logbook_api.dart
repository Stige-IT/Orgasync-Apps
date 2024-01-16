part of "../logbook.dart";

abstract class LogBookApi {
  Future<Either<String, bool>> createLogBook(LogBook logBook, String idCompany);
  Future<Either<String, bool>> updateLogBook(LogBook logBook);
  Future<Either<String, bool>> deleteLogBook(String idLogbook);
  Future<Either<String, ResponseData<List<LogBook>>>> getLogBooks(
      String idCompany,
      {required int page});
  Future<Either<String, LogBook>> getDetailLogBook(String idLogBook);
}

final logBookProvider = Provider<LogBookApiImpl>((ref) {
  return LogBookApiImpl(
      ref.watch(httpRequestProvider), ref.watch(storageProvider), ref);
});

class LogBookApiImpl implements LogBookApi {
  final HttpRequestClient _httpRequest;
  final SecureStorage _storage;
  final Ref ref;

  const LogBookApiImpl(this._httpRequest, this._storage, this.ref);

  @override
  Future<Either<String, ResponseData<List<LogBook>>>> getLogBooks(
      String idCompany,
      {required int page}) async {
    String url;
    url = "${ConstantUrl.BASE_URL}/logbook?id_company=$idCompany&page=$page";
    final role = ref.watch(roleInCompanyNotifier).data;
    if (role != Role.owner) {
      url =
          "${ConstantUrl.BASE_URL}/logbook/me?id_company=$idCompany&page=$page";
    }
    final response = await _httpRequest.get(url);
    return response.fold(
      (error) => left(error),
      (result) {
        List data = result["items"];
        final logBooks = data
            .map<LogBook>((e) => LogBook.fromJson(e))
            .toList(growable: false);
        return right(ResponseData(
          data: logBooks,
          total: result['total'],
          currentPage: result['page'],
          lastPage: result['pages'],
        ));
      },
    );
  }

  @override
  Future<Either<String, LogBook>> getDetailLogBook(String idLogBook) {
    final url = "${ConstantUrl.BASE_URL}/logbook/$idLogBook";
    return _httpRequest.get(url).then((response) {
      return response.fold(
        (error) => left(error),
        (result) => right(LogBook.fromJson(result)),
      );
    });
  }

  @override
  Future<Either<String, bool>> createLogBook(
    LogBook logBook,
    String idCompany,
  ) async {
    final url = "${ConstantUrl.BASE_URL}/logbook?id_company=$idCompany";
    final body = logBook.toJson();
    final response = await _httpRequest.post(url, body: body);
    return response.fold(
      (error) => left(error),
      (result) => right(true),
    );
  }

  @override
  Future<Either<String, bool>> deleteLogBook(String idLogbook) async {
    final url = "${ConstantUrl.BASE_URL}/logbook/$idLogbook";
    final response = await _httpRequest.delete(url);
    return response.fold(
      (error) => left(error),
      (result) => right(true),
    );
  }

  @override
  Future<Either<String, bool>> updateLogBook(LogBook logBook) {
    final url = "${ConstantUrl.BASE_URL}/logbook/${logBook.id}";
    final body = logBook.toJson();
    return _httpRequest.put(url, data: body).then((response) {
      return response.fold(
        (error) => left(error),
        (result) => right(true),
      );
    });
  }
}
