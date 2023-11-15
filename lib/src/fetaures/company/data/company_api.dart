part of "../company.dart";

abstract class CompanyApi {
  Future<Either<String, ResponseData<List<MyCompany>>>> getCompany(int page);
  Future<Either<String, bool>> joinCompany(String code);
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
        log(result.toString());
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
  Future<Either<String, bool>> joinCompany(String code)async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/company/me/join?code=$code");
    final token = await storage.read("token");
    final response = await client.post(url, headers: {
      "Authorization" : "Bearer $token",
    });
    switch(response.statusCode){
      case 201:
        return const Right(true);
      default:
        final message = jsonDecode(response.body)['message'];
        return Left(message);
    }
  }


}
