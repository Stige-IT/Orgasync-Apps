part of "../company.dart";

abstract class CompanyApi {
  Future<Either<String, ResponseData<List<MyCompany>>>> getCompany(int page);
  Future<Either<String, CompanyDetail>> getDetail(String companyId);

  Future<Either<String, bool>> joinCompany(String code);
  Future<Either<String, bool>> leaveCompany(String companyId);
  Future<Either<String, bool>> createCompany(CompanyRequest companyRequest);
  Future<Either<String, bool>> deleteCompany(String companyId);
  Future<Either<String, String>> checkRoleInCompany(String companyId);
  Future<Either<String, bool>> addEmployee(String companyId,
      {required List<String> emails});
}

final companyProvider = Provider<CompanyApiImpl>((ref) {
  return CompanyApiImpl(ref.watch(httpProvider), ref.watch(storageProvider),
      ref.watch(httpRequestProvider));
});

class CompanyApiImpl implements CompanyApi {
  final Client client;
  final SecureStorage storage;
  final HttpRequest httpRequest;

  CompanyApiImpl(this.client, this.storage, this.httpRequest);

  @override
  Future<Either<String, ResponseData<List<MyCompany>>>> getCompany(
      int page) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/company/joined?page=$page");
    final token = await storage.read("token");
    final response = await client.get(url, headers: {
      "Authorization": "Bearer $token",
    });

    switch (response.statusCode) {
      case 200:
        final data = jsonDecode(response.body);
        List result = jsonDecode(response.body)['items'];
        final company = result.map((e) => MyCompany.fromJson(e)).toList();
        return Right(
          ResponseData(
              data: company,
              total: data['total'],
              currentPage: data['page'],
              lastPage: data['pages']),
        );
      default:
        return Left("error".tr());
    }
  }

  @override
  Future<Either<String, CompanyDetail>> getDetail(String companyId) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/company/$companyId");
    final token = await storage.read('token');
    final response =
        await client.get(url, headers: {"Authorization": "Bearer $token"});
    switch (response.statusCode) {
      case 200:
        final result = jsonDecode(response.body);
        final data = CompanyDetail.fromJson(result);
        return Right(data);
      default:
        return Left("failed".tr());
    }
  }

  @override
  Future<Either<String, bool>> joinCompany(String code) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/company/join?code=$code");
    final token = await storage.read("token");
    final response = await client.post(url, headers: {
      "Authorization": "Bearer $token",
    });
    switch (response.statusCode) {
      case 201:
        return const Right(true);
      default:
        final message = jsonDecode(response.body)['message'];
        return Left(message);
    }
  }

  @override
  Future<Either<String, bool>> leaveCompany(String companyId) {
    final url = "${ConstantUrl.BASE_URL}/company/$companyId/leave";
    return httpRequest.delete(url).then((value) {
      return value.fold(
        (failure) => left(failure),
        (success) => right(success),
      );
    });
  }

  @override
  Future<Either<String, bool>> createCompany(
      CompanyRequest companyRequest) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/company");
    final token = await storage.read("token");
    final response = await client
        .post(url, body: jsonEncode(companyRequest.toJson()), headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    });

    switch (response.statusCode) {
      case 201:
        return const Right(true);
      case 422:
        final message = jsonDecode(response.body)["detail"];
        if (message["email"] == "registered") {
          return Left("already_registered".tr());
        }
        return Left("failed".tr());
      default:
        return Left("failed".tr());
    }
  }

  @override
  Future<Either<String, String>> checkRoleInCompany(String companyId) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/company/$companyId/role");
    final token = await storage.read("token");
    final response = await client.get(url, headers: {
      "Authorization": "Bearer $token",
    });
    switch (response.statusCode) {
      case 200:
        final role = jsonDecode(response.body)['type']['name'];
        return Right(role);
      default:
        return Left("failed".tr());
    }
  }

  @override
  Future<Either<String, bool>> addEmployee(String companyId,
      {required List<String> emails}) async {
    Uri url =
        Uri.parse("${ConstantUrl.BASE_URL}/company/$companyId/add-employee");
    final token = await storage.read("token");
    final response = await client.post(url, body: jsonEncode(emails), headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    });
    switch (response.statusCode) {
      case 201:
        return const Right(true);
      case 401:
        return Left("user_has_registered".tr());
      default:
        return Left("failed".tr());
    }
  }

  @override
  Future<Either<String, bool>> deleteCompany(String companyId) async {
    final url = "${ConstantUrl.BASE_URL}/company/$companyId";
    final response = await httpRequest.delete(url);
    return response.fold(
      (failure) => left(failure),
      (success) => right(success),
    );
  }
}
