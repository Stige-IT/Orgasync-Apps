part of "../../project.dart";

abstract class TaskApi {
  // get task
  Future<Either<String, TaskDataModel>> getTasks(String idProject);
  // get detail task
  Future<Either<String, TaskItem>> getDetailTask(String taskId);
  // create new task
  Future<Either<String, bool>> createTask(String idProject, TaskItem taskItem);
  // update task
  Future<Either<String, bool>> updateTask(String taskId, TaskItem taskItem);
  // delete task
  Future<Either<String, bool>> deleteTask(String taskId);
}

final taskProvider = Provider<TaskImpl>((ref) {
  return TaskImpl(httpRequest: ref.watch(httpRequestProvider));
});

class TaskImpl implements TaskApi {
  final HttpRequestClient httpRequest;

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
  Future<Either<String, TaskItem>> getDetailTask(String taskId) async {
    final url = "${ConstantUrl.BASE_URL}/task/$taskId";
    final response = await httpRequest.get(url);
    return response.fold(
      (error) => Left(error),
      (data) => Right(TaskItem.fromJson(data)),
    );
  }

  @override
  Future<Either<String, bool>> createTask(
      String idProject, TaskItem taskItem) async {
    final url = "${ConstantUrl.BASE_URL}/task?id_project=$idProject";
    final response = await httpRequest.post(url, body: taskItem.toRequest());
    return response.fold(
      (error) => Left(error),
      (data) => const Right(true),
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

  @override
  Future<Either<String, bool>> deleteTask(String taskId) async {
    final url = "${ConstantUrl.BASE_URL}/task/$taskId";
    final response = await httpRequest.delete(url);
    return response.fold(
      (error) => Left(error),
      (data) => const Right(true),
    );
  }
}
