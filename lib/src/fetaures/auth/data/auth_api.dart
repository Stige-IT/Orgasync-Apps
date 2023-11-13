part of "../auth.dart";

abstract class AuthApi {
  Future login(String email, String password);

  Future register(
      {required String name, required String email, required String password});

  Future logout();
}

final authProvider = Provider<AuthApiImpl>((ref) {
  return AuthApiImpl(ref.watch(httpProvider));
});

class AuthApiImpl implements AuthApi {
  final Client client;

  AuthApiImpl(this.client);

  @override
  Future<Either<String, bool>> login(String email, String password) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/auth/login");
    final response = await client.post(url,
        body: jsonEncode({"email": email, "password": password}),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return const Right(true);
    } else if (response.statusCode == 400) {
      final message = jsonDecode(response.body)["detail"];
      if (message["email"] == "not_active") {
        return Left("not_active".tr());
      } else if (message['email'] == "not_verified") {
        return Left("not_verified".tr());
      }
      return const Left("Email atau Password Salah");
    } else {
      return const Left("Gagal masuk, coba kembali");
    }
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
  Future logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
