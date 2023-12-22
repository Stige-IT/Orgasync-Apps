part of "../employee.dart";

abstract class EmployeeApi {
  Future<Either<String, ResponseData<List<Employee>>>> getEmployees(
      {int? page});
  Future<Either<String, ResponseData<List<Employee>>>> getEmployeeCompany(
      String companyId,
      {int page = 1});
  // update employee
  Future<Either<String, bool>> updateEmployee(String id,
      {required String idTypeEmployee});
  // delete employee
  Future<Either<String, bool>> deleteEmployee(String employeeId);
  // type employee
  Future<Either<String, List<TypeEmployee>>> getTypeEmployee();
  // create type employee
  Future<Either<String, bool>> createTypeEmployee(String name, int level);

  // search employee in company
  Future<Either<String, List<Employee>>> searchEmployee(String idCompany,
      {String? query});
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
    Uri url = Uri.parse(
        "${ConstantUrl.BASE_URL}/company/$companyId/employee?page=$page");
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
  Future<Either<String, bool>> deleteEmployee(String employeeId) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/employee/$employeeId");
    final token = await storage.read("token");
    final response = await client.delete(url, headers: {
      "Authorization": "Bearer $token",
    });
    switch (response.statusCode) {
      case 200:
        return const Right(true);
      default:
        return Left("failed".tr());
    }
  }

  // type employee
  @override
  Future<Either<String, List<TypeEmployee>>> getTypeEmployee() async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/employee/show/type");
    final token = await storage.read("token");
    final response = await client.get(url, headers: {
      "Authorization": "Bearer $token",
    });
    switch (response.statusCode) {
      case 200:
        List result = jsonDecode(response.body);
        final data = result.map((e) => TypeEmployee.fromJson(e)).toList();
        return Right(data);
      default:
        return Left("failed".tr());
    }
  }

  // create employee
  @override
  Future<Either<String, bool>> createTypeEmployee(
      String name, int level) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/create/type");
    final token = await storage.read("token");
    final data = {"name": name, "level": level};
    final headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };

    final response =
        await client.post(url, body: jsonEncode(data), headers: headers);
    switch (response.statusCode) {
      case 201:
        return const Right(true);
      default:
        return Left("failed".tr());
    }
  }

  @override
  Future<Either<String, bool>> updateEmployee(String id,
      {required String idTypeEmployee}) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/employee/$id");
    final token = await storage.read("token");
    final data = {"id_type_employee": idTypeEmployee};
    final headers = {"Authorization": "Bearer $token"};

    final response = await client.put(url, body: data, headers: headers);
    switch (response.statusCode) {
      case 200:
        return const Right(true);
      default:
        return Left("failed".tr());
    }
  }

  @override
  Future<Either<String, List<Employee>>> searchEmployee(String idCompany,
      {String? query}) async {
    Uri url = Uri.parse(
        "${ConstantUrl.BASE_URL}/employee/search/$idCompany?query=$query");
    final token = await storage.read("token");
    final response = await client.get(url, headers: {
      "Authorization": "Bearer $token",
    });
    switch (response.statusCode) {
      case 200:
        List result = jsonDecode(response.body)['items'];
        final data = result.map((e) => Employee.fromJson(e)).toList();
        return right(data);
      default:
        return left("error".tr());
    }
  }
}
