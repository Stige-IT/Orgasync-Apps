part of "../employee.dart";

abstract class EmployeeApi {
  Future<Either<String, ResponseData<List<Employee>>>> getEmployees(
      {int? page});
  Future<Either<String, ResponseData<List<Employee>>>> getEmployeeCompany(
      String companyId,
      {int page = 1});
}

final employeeProvider = Provider<EmployeeImpl>((ref) {
  return EmployeeImpl(ref.watch(httpProvider), ref.watch(storageProvider));
});

class EmployeeImpl implements EmployeeApi {
  final Client client;
  final SecureStorage storage;

  EmployeeImpl(this.client, this.storage);

  @override
  Future<Either<String, ResponseData<List<Employee>>>> getEmployees(
      {int? page}) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/employee?page=$page");
    final token = await storage.read("token");
    final response = await client.get(url, headers: {
      "Authorization": "Bearer $token",
    });
    switch (response.statusCode) {
      case 200:
        List result = jsonDecode(response.body)['items'];
        final data = result.map((e) => Employee.fromJson(e)).toList();
        return Right(
          ResponseData(
              data: data,
              total: jsonDecode(response.body)['total'],
              currentPage: jsonDecode(response.body)['page'],
              lastPage: jsonDecode(response.body)['pages']),
        );
      default:
        return Left("failed".tr());
    }
  }

  @override
  Future<Either<String, ResponseData<List<Employee>>>> getEmployeeCompany(
      String companyId,
      {int page = 1}) async {
    final companyId = await storage.read("id_company");
    Uri url = Uri.parse(
        "${ConstantUrl.BASE_URL}/company/me/employee?id_company=$companyId&page=$page");
    final token = await storage.read("token");
    final response = await client.get(url, headers: {
      "Authorization": "Bearer $token",
    });
    switch (response.statusCode) {
      case 200:
        List result = jsonDecode(response.body)['items'];
        final data = result.map((e) => Employee.fromJson(e)).toList();
        return Right(
          ResponseData(
              data: data,
              total: jsonDecode(response.body)['total'],
              currentPage: jsonDecode(response.body)['page'],
              lastPage: jsonDecode(response.body)['pages']),
        );
      default:
        return Left("failed".tr());
    }
  }
}
