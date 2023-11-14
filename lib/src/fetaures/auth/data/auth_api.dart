part of "../auth.dart";

abstract class AuthApi {
  Future<Either<ErrorAccountResponse, TypeAccount>> login(
      String email, String password);

  Future<Either<String, bool>> register(
      {required String name, required String email, required String password});

  Future<Either<String, bool>> companyRegister(CompanyRequest companyRequest);

  Future<Either<String, bool>> verification({
    required String email,
    required String code,
    required TypeVerification type,
  });

  Future<Either<String, bool>> resendCode(String email);

  Future logout();
}

final authProvider = Provider<AuthApiImpl>((ref) {
  return AuthApiImpl(ref.watch(httpProvider));
});

class AuthApiImpl implements AuthApi {
  final Client client;

  AuthApiImpl(this.client);

  @override
  Future<Either<ErrorAccountResponse, TypeAccount>> login(
      String email, String password) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/auth/login");
    final response = await client.post(url,
        body: jsonEncode({"email": email, "password": password}),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return const Right(TypeAccount.verified);
    } else if (response.statusCode == 400) {
      final message = jsonDecode(response.body)["detail"];
      if (message["email"] == "not_active") {
        return Left(ErrorAccountResponse(TypeAccount.notActive,
            message: "not_active".tr()));
      } else if (message['email'] == "not_verified") {
        return Left(ErrorAccountResponse(TypeAccount.notVerified,
            message: "not_verified".tr()));
      }
    } else if (response.statusCode == 404) {
      return Left(ErrorAccountResponse(TypeAccount.notFound,
          message: "not_found".tr()));
    }
    return Left(ErrorAccountResponse(TypeAccount.error,
        message: "Gagal masuk, coba kembali"));
  }

  @override
  Future<Either<String, bool>> register(
      {required String name,
      required String email,
      required String password}) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/auth/register");
    final data = {"name": name, "email": email, "password": password};
    final response = await client.post(
      url,
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 201) {
      return const Right(true);
    } else if (response.statusCode == 422) {
      final message = jsonDecode(response.body)["detail"];
      if (message["email"] == "registered") {
        return Left("already_registered".tr());
      }
    }
    return const Left("Gagal Mendaftar, coba kembali");
  }

  @override
  Future<Either<String, bool>> companyRegister(
      CompanyRequest companyRequest) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/company/register");
    final response = await client.post(
      url,
      body: jsonEncode(companyRequest.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 201) {
      return const Right(true);
    } else if (response.statusCode == 422) {
      final message = jsonDecode(response.body)["detail"];
      if (message["email"] == "registered") {
        return Left("already_registered".tr());
      }
    }
    return const Left("Gagal Mendaftar, coba kembali");
  }

  @override
  Future<Either<String, bool>> verification({
    required String email,
    required String code,
    required TypeVerification type,
  }) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/auth/verify");
    final response = await client.post(
      url,
      body: jsonEncode({"email": email, "code": int.parse(code)}),
      headers: {"Content-Type": "application/json"},
    );
    switch (response.statusCode) {
      case 200:
        return const Right(true);
      case 400:
        return Left("code_expired".tr());
      default:
        return Left("code_invalid".tr());
    }
  }

  @override
  Future<Either<String, bool>> resendCode(String email) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/auth/resend?email=$email");
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return const Right(true);
    } else if (response.statusCode == 400) {
      return Left("code_expired".tr());
    }
    return Left("not_found".tr());
  }

  @override
  Future logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
