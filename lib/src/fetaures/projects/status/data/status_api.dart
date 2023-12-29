part of "../../project.dart";

abstract class StatusApi {
  // get Status
  Future<Either<String, List<Status>>> getStatus();
}

final statusProvider = Provider<StatusImpl>((ref) {
  return StatusImpl(httpRequest: ref.watch(httpRequestProvider));
});

class StatusImpl implements StatusApi {
  final HttpRequest httpRequest;

  StatusImpl({required this.httpRequest});

  @override
  Future<Either<String, List<Status>>> getStatus() async {
    const url = "${ConstantUrl.BASE_URL}/status";
    final response = await httpRequest.get(url);
    return response.fold(
      (error) => Left(error),
      (data) {
        final status = (data as List).map((e) => Status.fromJson(e)).toList();
        return Right(status);
      },
    );
  }
}
