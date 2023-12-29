part of "../../project.dart";

abstract class TaskApi {
  // get task
  Future<Either<String, TaskDataModel>> getTasks(String idProject);
  // update task
  Future<Either<String, bool>> updateTask(String taskId, TaskItem taskItem);
}

final taskProvider = Provider<TaskImpl>((ref) {
  return TaskImpl(httpRequest: ref.watch(httpRequestProvider));
});

class TaskImpl implements TaskApi {
  final HttpRequest httpRequest;

  TaskImpl({required this.httpRequest});

  @override
  Future<Either<String, TaskDataModel>> getTasks(String idProject) async {
    final url = "${ConstantUrl.BASE_URL}/task?id_project=$idProject";
    final response = await httpRequest.get(url);
    return response.fold(
      (error) => Left(error),
      (data) => Right(TaskDataModel.fromJson(data)),
    );
  }

  @override
  Future<Either<String, bool>> updateTask(
    String taskId,
    TaskItem taskItem,
  ) async {
    final url = "${ConstantUrl.BASE_URL}/task/$taskId";
    final response = await httpRequest.put(url, data: taskItem.toRequest());
    return response.fold(
      (error) => Left(error),
      (data) => const Right(true),
    );
  }
}
