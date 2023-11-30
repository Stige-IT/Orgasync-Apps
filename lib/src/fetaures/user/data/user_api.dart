part of "../user.dart";

abstract class UserApi {
  Future<Either<String, UserData>> getUserData();

  // edit profile
  Future<Either<String, bool>> editProfile(
      {String? name, String? email, File? image});

  // get user address
  Future<Either<String, Address>> getUserAddress();
  // edit user address
  Future<Either<String, bool>> editUserAddress(AddressRequest address);

  // edit password
  Future<Either<String, bool>> editPassword(
      String password, String newPassword);
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

  @override
  Future<Either<String, bool>> editProfile({
    String? name,
    String? email,
    File? image,
  }) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/me");
    final token = await storage.read("token");
    final request = http.MultipartRequest("PUT", url);
    request.headers["Authorization"] = "Bearer $token";
    if (name != null) {
      request.fields["name"] = name;
    }
    if (email != null) {
      request.fields["email"] = email;
    }
    if (image != null) {
      final file = http.MultipartFile(
        "image",
        image.readAsBytes().asStream(),
        image.lengthSync(),
        filename: image.path.split("/").last,
      );
      request.files.add(file);
    }
    final response = await request.send();
    switch (response.statusCode) {
      case 200:
        return const Right(true);
      default:
        return Left("error".tr());
    }
  }

  @override
  Future<Either<String, Address>> getUserAddress() async {
    Uri url = Uri.parse('${ConstantUrl.BASE_URL}/address/me');
    final token = await storage.read("token");
    final response =
        await client.get(url, headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final address = Address.fromJson(data);
      return Right(address);
    } else {
      return Left("error".tr());
    }
  }

  @override
  Future<Either<String, bool>> editUserAddress(AddressRequest address) async {
    Uri url = Uri.parse('${ConstantUrl.BASE_URL}/address/me');
    final token = await storage.read("token");
    final headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
    final response = await client.put(
      url,
      headers: headers,
      body: jsonEncode(address.toJson()),
    );
    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return Left("error".tr());
    }
  }

  @override
  Future<Either<String, bool>> editPassword(
    String password,
    String newPassword,
  ) async {
    Uri url = Uri.parse('${ConstantUrl.BASE_URL}/me/change-password');
    final token = await storage.read("token");
    final headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
    final body = {
      "password": password,
      "new_password": newPassword,
    };
    final response =
        await client.put(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return Left("error".tr());
    }
  }
}
