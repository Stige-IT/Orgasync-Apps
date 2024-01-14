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
  Future<Either<String, DetailCompanyProject>> detailCompanyProject(String id);

  // update company project
  Future<Either<String, bool>> updateCompanyProject(String id,
      {required String name, required String description, File? image});

  // delete company project by id
  Future<Either<String, bool>> deleteCompanyProject(String id);

  // get member company project
  Future<Either<String, ResponseData<List<EmployeeCompanyProject>>>>
      getMemberCompanyProject(String idCompanyProject, {int? page});

  // add member to company project
  Future<Either<String, bool>> addMemberToCompanyProject(
      String idCompanyProject, List<String> idUser);

  // remove member from company project
  Future<Either<String, bool>> removeMemberFromCompanyProject(
      String idCompanyProject, String idUser);
}

final companyProjectProvider = Provider<CompanyProjectImpl>((ref) {
  return CompanyProjectImpl(ref.watch(httpProvider), ref.watch(storageProvider),
      ref.watch(httpRequestProvider));
});

class CompanyProjectImpl implements CompanyProjectApi {
  final Client _client;
  final SecureStorage storage;
  final HttpRequestClient httpRequest;

  CompanyProjectImpl(this._client, this.storage, this.httpRequest);

  @override
  Future<Either<String, ResponseData<List<CompanyProject>>>> getProjects(
      String idCompany,
      {int? page}) async {
    Uri url = Uri.parse(
        "${ConstantUrl.BASE_URL}/company-project?id_company=$idCompany&page=$page");
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
        "${ConstantUrl.BASE_URL}/company-project?id_company=$idCompany");
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

  // update company project

  @override
  Future<Either<String, bool>> updateCompanyProject(
    String id, {
    required String name,
    required String description,
    File? image,
  }) async {
    final url = "${ConstantUrl.BASE_URL}/company-project/$id";
    final result = await httpRequest.multipart(
      "PUT",
      url,
      data: {"name": name, "description": description},
      files: [image!],
      fieldFiles: ["image"],
    );
    return result.fold(
      (failure) => left(failure),
      (response) => right(response),
    );
  }

  // delete company project by id
  @override
  Future<Either<String, bool>> deleteCompanyProject(String id) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/company-project/$id");
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
  Future<Either<String, DetailCompanyProject>> detailCompanyProject(
      String id) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/company-project/$id");
    final token = await storage.read("token");
    final response = await _client.get(url, headers: {
      "Authorization": "Bearer $token",
    });

    switch (response.statusCode) {
      case 200:
        final data = jsonDecode(response.body);
        return right(DetailCompanyProject.fromJson(data));
      default:
        return left("error".tr());
    }
  }

  @override
  Future<Either<String, ResponseData<List<EmployeeCompanyProject>>>>
      getMemberCompanyProject(String idCompanyProject, {int? page = 1}) async {
    final url =
        "${ConstantUrl.BASE_URL}/company-project/$idCompanyProject/employee?page=$page";
    final response = await httpRequest.get(url);
    return response.fold(
      (failure) => left(failure),
      (response) {
        List result = response['items'];
        final data =
            result.map((e) => EmployeeCompanyProject.fromJson(e)).toList();
        final total = response['total'];
        final currentPage = response['page'];
        final lastPage = response['pages'];
        return right(ResponseData(
          data: data,
          total: total,
          currentPage: currentPage,
          lastPage: lastPage,
        ));
      },
    );
  }

  @override
  Future<Either<String, bool>> addMemberToCompanyProject(
      String idCompanyProject, List<String> idUser) async {
    final url =
        "${ConstantUrl.BASE_URL}/company-project/$idCompanyProject/employee";
    final response = await httpRequest.post(url, body: {"employee_id": idUser});
    return response.fold(
      (failure) => left(failure),
      (success) => right(success),
    );
  }

  @override
  Future<Either<String, bool>> removeMemberFromCompanyProject(
      String idCompanyProject, String idUser) async {
    final url =
        "${ConstantUrl.BASE_URL}/company-project/$idCompanyProject/employee/$idUser";
    final response = await httpRequest.delete(url);
    return response.fold(
      (failure) => left(failure),
      (success) => right(success),
    );
  }
}
