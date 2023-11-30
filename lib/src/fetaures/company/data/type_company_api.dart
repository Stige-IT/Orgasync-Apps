part of "../company.dart";

abstract class TypeCompanyApi {
  Future<Either<String, List<TypeCompany>>> getTypeCompany();
}

final typeCompanyProvider = Provider<TypeCompanyImpl>((ref) {
  return TypeCompanyImpl(client: ref.watch(httpProvider));
});

class TypeCompanyImpl implements TypeCompanyApi {
  final Client client;

  TypeCompanyImpl({required this.client});

  @override
  Future<Either<String, List<TypeCompany>>> getTypeCompany() async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/type");
    final response = await client.get(url);
    switch (response.statusCode) {
      case 200:
        List result = jsonDecode(response.body);
        final typeCompany = result.map((e) => TypeCompany.fromJson(e)).toList();
        return Right(typeCompany);
      default:
        return Left("error".tr());
    }
  }
}
