part of "../../project.dart";

abstract class CompanyProjectApi {
  Future<Either<String, ResponseData<List<CompanyProject>>>> getProjects(
      String idCompany,
      {int? page});
}

final companyProjectProvider = Provider<CompanyProjectImpl>((ref) {
  return CompanyProjectImpl(
      ref.watch(httpProvider), ref.watch(storageProvider));
});

class CompanyProjectImpl implements CompanyProjectApi {
  final Client _client;
  final SecureStorage storage;

  CompanyProjectImpl(this._client, this.storage);

  @override
  Future<Either<String, ResponseData<List<CompanyProject>>>> getProjects(
      String idCompany,
      {int? page}) async {
    Uri url = Uri.parse(
        "${ConstantUrl.BASE_URL}/company/project?id_company=$idCompany&page=$page");
    final token = await storage.read("token");
    final response =
        await _client.get(url, headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      List result = jsonDecode(response.body)['items'];
      final data = result.map((e) => CompanyProject.fromJson(e)).toList();
      int total = jsonDecode(response.body)['total'];
      int page = jsonDecode(response.body)['page'];
      int pages = jsonDecode(response.body)['pages'];
      return right(ResponseData(
          data: data, total: total, currentPage: page, lastPage: pages));
    } else {
      return left("error".tr());
    }
  }
}
