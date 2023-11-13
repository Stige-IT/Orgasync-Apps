part of "../auth.dart";

abstract class AuthApi {
  Future login(String email, String password);

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
    }else if(response.statusCode == 400){
      return const Left("Email atau Password Salah");
    } else {
      return const Left("Gagal Masuk");
    }
  }

  @override
  Future logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
