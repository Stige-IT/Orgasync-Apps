part of "../company.dart";

abstract class CompanyApi {
  Future<Either<String, ResponseData<List<MyCompany>>>> getCompany(int page);
  Future<Either<String, CompanyDetail>> getDetail(String companyId);

  Future<Either<String, bool>> joinCompany(String code);
  Future<Either<String, bool>> createCompany(CompanyRequest companyRequest);
  Future<Either<String, String>> checkRoleInCompany(String companyId);
  Future<Either<String, bool>> addEmployee(String companyId,
      {required List<String> emails});
}

final companyProvider = Provider<CompanyApiImpl>((ref) {
  return CompanyApiImpl(ref.watch(httpProvider), ref.watch(storageProvider));
});

class CompanyApiImpl implements CompanyApi {
  final Client client;
  final SecureStorage storage;

  CompanyApiImpl(this.client, this.storage);

  @override
  Future<Either<String, ResponseData<List<MyCompany>>>> getCompany(
      int page) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/company/me?page=$page");
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
    Uri url = Uri.parse(
        "${ConstantUrl.BASE_URL}/company/me/detail?id_company=$companyId");
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
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/company/me/join?code=$code");
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
  Future<Either<String, bool>> createCompany(
      CompanyRequest companyRequest) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/company/me/create");
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
    Uri url = Uri.parse(
        "${ConstantUrl.BASE_URL}/company/me/role?id_company=$companyId");
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
    Uri url = Uri.parse(
        "${ConstantUrl.BASE_URL}/company/me/add-employee?id_company=$companyId");
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
}
