part of "../../project.dart";

abstract class CompanyProjectApi {
  Future<Either<String, ResponseData<List<CompanyProject>>>> getProjects(
      String idCompany,
      {int? page});

  // create company project
  Future<Either<String, bool>> createCompanyProject(
    String idCompany, {
    required String name,
    required String description,
    File? image,
  });

  // detail company project
  Future<Either<String, CompanyProject>> detailCompanyProject(String id);

  // delete company project by id
  Future<Either<String, bool>> deleteCompanyProject(String id);
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

  @override
  Future<Either<String, bool>> createCompanyProject(
    String idCompany, {
    required String name,
    required String description,
    File? image,
  }) async {
    Uri url = Uri.parse(
        "${ConstantUrl.BASE_URL}/company/project?id_company=$idCompany");
    final token = await storage.read("token");
    var request = http.MultipartRequest("POST", url)
      ..headers.addAll({"Authorization": "Bearer $token"})
      ..fields.addAll({
        "name": name,
        "description": description,
      });
    if (image != null) {
      request.files.add(http.MultipartFile.fromBytes(
          "image", image.readAsBytesSync(),
          filename: image.path.split("/").last));
    }
    final response = await request.send();
    switch (response.statusCode) {
      case 201:
        return right(true);
      default:
        return left("error".tr());
    }
  }

  // delete company project by id
  @override
  Future<Either<String, bool>> deleteCompanyProject(String id) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/company/project/$id");
    final token = await storage.read("token");
    final response =
        await _client.delete(url, headers: {"Authorization": "Bearer $token"});
    switch (response.statusCode) {
      case 200:
        return right(true);
      default:
        return left("error".tr());
    }
  }

  @override
  Future<Either<String, CompanyProject>> detailCompanyProject(String id) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/company/project/$id");
    final token = await storage.read("token");
    final response = await _client.get(url, headers: {
      "Authorization": "Bearer $token",
    });

    switch (response.statusCode) {
      case 200:
        final data = jsonDecode(response.body);
        return right(CompanyProject.fromJson(data));
      default:
        return left("error".tr());
    }
  }
}
