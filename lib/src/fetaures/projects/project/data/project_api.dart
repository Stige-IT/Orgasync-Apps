part of "../../project.dart";

abstract class ProjectApi {
  // get project by company project id
  Future<Either<String, List<Project>>> getProjects(String idCompanyProject);
  // get detail project
  Future<Either<String, Project>> detailProject(String idProject);
  // create new project
  Future<Either<String, bool>> createProject(String idCompanyProject,
      {required String name, required String description});
  // update project
  Future<Either<String, bool>> updateProject(String idProject,
      {required String name, required String description});
  // delete project
  Future<Either<String, bool>> deleteProject(String idProject);
}

// provider implementation api
final projectProvider = Provider<ProjectImpl>((ref) {
  return ProjectImpl(ref.watch(httpProvider), ref.watch(storageProvider),
      ref.watch(httpRequestProvider));
});

class ProjectImpl implements ProjectApi {
  final Client _client;
  final SecureStorage storage;
  final HttpRequest httpRequest;

  ProjectImpl(this._client, this.storage, this.httpRequest);

  @override
  Future<Either<String, List<Project>>> getProjects(
      String idCompanyProject) async {
    Uri url = Uri.parse(
        "${ConstantUrl.BASE_URL}/project?id_company_project=$idCompanyProject");
    final token = await storage.read("token");
    final response =
        await _client.get(url, headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      List result = jsonDecode(response.body);
      final data = result.map((e) => Project.fromJson(e)).toList();
      return right(data);
    } else {
      return left("error".tr());
    }
  }

  @override
  Future<Either<String, Project>> detailProject(String idProject) async {
    final url = "${ConstantUrl.BASE_URL}/project/$idProject";
    final result = await httpRequest.get(url);
    return result.fold(
      (error) => left(error),
      (response) => right(Project.fromJson(response)),
    );
  }

  @override
  Future<Either<String, bool>> createProject(String idCompanyProject,
      {required String name, required String description}) async {
    Uri url = Uri.parse(
        "${ConstantUrl.BASE_URL}/project?id_company_project=$idCompanyProject");
    final token = await storage.read("token");
    final headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
    final body = jsonEncode({"name": name, "description": description});
    final response = await _client.post(url, body: body, headers: headers);
    if (response.statusCode == 201) {
      return right(true);
    } else {
      return left("error".tr());
    }
  }

  @override
  Future<Either<String, bool>> deleteProject(String idProject) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/project/$idProject");
    final result = await httpRequest.delete(url.toString());
    return result.fold(
      (error) => left(error),
      (response) => right(response),
    );
  }

  @override
  Future<Either<String, bool>> updateProject(
    String idProject, {
    required String name,
    required String description,
  }) async {
    final url = "${ConstantUrl.BASE_URL}/project/$idProject";
    final body = {"name": name, "description": description};
    final result = await httpRequest.put(url, data: body);
    return result.fold(
      (error) => left(error),
      (response) => right(response),
    );
  }
}
