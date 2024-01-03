part of "../../project.dart";

abstract class PriorityApi {
  // get priorities
  Future<Either<String, List<Priority>>> getPriorities();
}

final priorityProvider = Provider<PriorityApiImpl>((ref) {
  return PriorityApiImpl(ref.watch(httpRequestProvider));
});

class PriorityApiImpl implements PriorityApi {
  final HttpRequest httpRequest;

  PriorityApiImpl(this.httpRequest);

  @override
  Future<Either<String, List<Priority>>> getPriorities() async {
    const url = "${ConstantUrl.BASE_URL}/priority";
    final response = await httpRequest.get(url);
    return response.fold(
      (error) => Left(error),
      (data) => Right(List<Priority>.from(
        data.map((x) => Priority.fromJson(x)),
      )),
    );
  }
}
