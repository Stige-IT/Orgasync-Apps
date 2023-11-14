part of "../user.dart";

abstract class UserApi {
  Future<Either<String, UserData>> getUserData();
}

final userProvider = StateProvider<UserApiImpl>((ref) {
  return UserApiImpl(ref.watch(httpProvider), ref.watch(storageProvider));
});


class UserApiImpl implements UserApi {
  final Client client;
  final SecureStorage storage;

  UserApiImpl(this.client, this.storage);

  @override
  Future<Either<String, UserData>> getUserData() async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/me");
    final token = await storage.read("token");
    final response = await client.get(url, headers: {
      "Authorization": "Bearer $token",
    });
    switch (response.statusCode) {
      case 200:
        final data = jsonDecode(response.body);
        final userData = UserData.fromJson(data);
        return Right(userData);
      default:
        return Left("not_found".tr());
    }
  }
}
