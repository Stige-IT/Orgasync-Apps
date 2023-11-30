part of "../address.dart";

abstract class AddressApi {
  Future<List<AddressDetail>> getAddress({String title = "province", int? id});
}

final addressProvider = Provider<AddressApiImpl>((ref) {
  return AddressApiImpl(ref.read(httpProvider));
});

class AddressApiImpl implements AddressApi {
  final Client _client;

  AddressApiImpl(this._client);

  @override
  Future<List<AddressDetail>> getAddress(
      {String title = "province", int? id}) async {
    Uri url = Uri.parse("${ConstantUrl.BASE_URL}/address/$title");
    if (title != "province") {
      url = Uri.parse("${ConstantUrl.BASE_URL}/address/$id/$title");
    }
    final response = await _client.get(url);
    switch (response.statusCode) {
      case 200:
        List result = jsonDecode(response.body);
        final data = result.map((e) => AddressDetail.fromJson(e)).toList();
        return data;
      default:
        return [];
    }
  }
}
