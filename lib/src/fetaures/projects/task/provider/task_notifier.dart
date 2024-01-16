part of "../../project.dart";

// get task
class TaskNotifier extends StateNotifier<BaseState<TaskDataModel>> {
  final TaskApi taskApi;
  final Ref ref;
  TaskNotifier(this.taskApi, this.ref) : super(const BaseState());

  Future<void> getTasks(String idProject) async {
    try {
      final response = await taskApi.getTasks(idProject);
      response.fold(
        (error) => state = state.copyWith(error: error),
        (data) => state = state.copyWith(data: data),
      );
    } catch (e) {
      state = state.copyWith(error: exceptionTomessage(e));
    }
  }

  Future<bool> changeStatus(TaskItem taskItem, Status newStatus) async {
    final temp = state.data;
    TaskDataModel newTaskModel = TaskDataModel(
      todo: state.data!.todo,
      doing: state.data!.doing,
      done: state.data!.done,
    );

    // remove from todo
    log("taskItem.status.name ${taskItem.status?.name}");
    switch (taskItem.status?.name) {
      case "todo":
        final newTodo = state.data!.todo!..remove(taskItem);
        newTaskModel.todo = newTodo;
        break;
      case "doing":
        final newDoing = state.data!.doing!..remove(taskItem);
        newTaskModel.doing = newDoing;
        break;
      case "done":
        final newDone = state.data!.done!..remove(taskItem);
        newTaskModel.done = newDone;
        break;
      default:
    }

    // change status task item
    taskItem.status = newStatus;

    // add to todo
    log("newStatus.name ${newStatus.name}");
    switch (newStatus.name) {
      case "todo":
        final newTodo = state.data!.todo!..add(taskItem);
        newTaskModel.todo = newTodo;
        break;
      case "doing":
        final newDoing = state.data!.doing!..add(taskItem);
        newTaskModel.doing = newDoing;
        break;
      case "done":
        final newDone = state.data!.done!..add(taskItem);
        newTaskModel.done = newDone;
        break;
      default:
    }

    state = state.copyWith(data: newTaskModel);
    final result = await ref
        .watch(updateTaskNotifier.notifier)
        .updateTask(taskItem.id!, taskItem);

    return result.fold(
      (error) {
        state = state.copyWith(data: temp);
        return false;
      },
      (success) => true,
    );
  }

  // change assigneed
  Future<bool> changeAssigned(
    TaskItem taskItem,
    EmployeeCompanyProject? newEmployee,
  ) async {
    final temp = state.data;
    TaskDataModel newTaskModel = TaskDataModel(
      todo: state.data!.todo,
      doing: state.data!.doing,
      done: state.data!.done,
    );

    switch (taskItem.status?.name) {
      case "todo":
        final index = state.data?.todo
            ?.indexWhere((element) => element.id == taskItem.id);
        if (index != null) {
          Assignee newAssignee = Assignee(
            id: newEmployee?.id,
            employee: newEmployee?.employee,
          );
          newTaskModel.todo?[index].assignee = newAssignee;
        }
        break;
      case "doing":
        final index = state.data?.doing
            ?.indexWhere((element) => element.id == taskItem.id);
        if (index != null) {
          Assignee newAssignee = Assignee(
            id: newEmployee?.id,
            employee: newEmployee?.employee,
          );
          newTaskModel.doing?[index].assignee = newAssignee;
        }
        break;
      case "done":
        final index = state.data?.done
            ?.indexWhere((element) => element.id == taskItem.id);
        if (index != null) {
          Assignee newAssignee = Assignee(
            id: newEmployee?.id,
            employee: newEmployee?.employee,
          );
          newTaskModel.done?[index].assignee = newAssignee;
        }
        break;
      default:
    }

    state = state.copyWith(data: newTaskModel);

    final result = await ref
        .watch(updateTaskNotifier.notifier)
        .updateTask(taskItem.id!, taskItem);
    return result.fold(
      (error) {
        state = state.copyWith(data: temp);
        return false;
      },
      (success) => true,
    );
  }

  // remove assigneed
  Future<bool> removeAssigned(TaskItem taskItem) async {
    final temp = state.data;
    TaskDataModel newTaskModel = TaskDataModel(
      todo: state.data!.todo,
      doing: state.data!.doing,
      done: state.data!.done,
    );

    switch (taskItem.status?.name) {
      case "todo":
        final index = state.data?.todo
            ?.indexWhere((element) => element.id == taskItem.id);
        if (index != null) {
          newTaskModel.todo?[index].assignee = null;
        }
        break;
      case "doing":
        final index = state.data?.doing
            ?.indexWhere((element) => element.id == taskItem.id);
        if (index != null) {
          newTaskModel.doing?[index].assignee = null;
        }
        break;
      case "done":
        final index = state.data?.done
            ?.indexWhere((element) => element.id == taskItem.id);
        if (index != null) {
          newTaskModel.done?[index].assignee = null;
        }
        break;
      default:
    }

    state = state.copyWith(data: newTaskModel);

    final result = await ref
        .watch(updateTaskNotifier.notifier)
        .updateTask(taskItem.id!, taskItem);

    return result.fold(
      (error) {
        state = state.copyWith(data: temp);
        return false;
      },
      (success) => true,
    );
  }

  // remove
  Future<bool> removeTask(TaskItem taskItem) async {
    final temp = state.data;
    TaskDataModel newTaskModel = TaskDataModel(
      todo: state.data!.todo,
      doing: state.data!.doing,
      done: state.data!.done,
    );

    switch (taskItem.status?.name) {
      case "todo":
        final index = state.data?.todo
            ?.indexWhere((element) => element.id == taskItem.id);
        if (index != null) {
          newTaskModel.todo?.removeAt(index);
        }
        break;
      case "doing":
        final index = state.data?.doing
            ?.indexWhere((element) => element.id == taskItem.id);
        if (index != null) {
          newTaskModel.doing?.removeAt(index);
        }
        break;
      case "done":
        final index = state.data?.done
            ?.indexWhere((element) => element.id == taskItem.id);
        if (index != null) {
          newTaskModel.done?.removeAt(index);
        }
        break;
      default:
    }

    state = state.copyWith(data: newTaskModel);
    final result =
        await ref.watch(deleteTaskNotifier.notifier).deleteTask(taskItem.id!);
    return result.fold(
      (error) {
        state = state.copyWith(data: temp);
        return false;
      },
      (success) => true,
    );
  }
}

// task me
class TaskMeNotifier extends StateNotifier<States<List<TaskMe>>> {
  final TaskApi taskApi;
  TaskMeNotifier(this.taskApi) : super(States.noState());

  void get(String idCompany) async {
    state = States.loading();
    try {
      final response = await taskApi.getTasksMe(idCompany);
      response.fold(
        (error) => state = States.error(error),
        (data) => state = States.finished(data),
      );
    } catch (e) {
      state = States.error(exceptionTomessage(e));
    }
  }
}

// get detail task by id
class DetailTaskNotifier extends StateNotifier<BaseState<TaskItem>> {
  final TaskApi taskApi;
  DetailTaskNotifier(this.taskApi) : super(const BaseState());

  Future<void> getDetailTask(String taskId) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await taskApi.getDetailTask(taskId);
      response.fold(
        (error) => state = state.copyWith(error: error, isLoading: false),
        (data) => state = state.copyWith(data: data, isLoading: false),
      );
    } catch (e) {
      state = state.copyWith(error: exceptionTomessage(e), isLoading: false);
    }
  }
}

// create new task
class AddTaskNotifier extends StateNotifier<States> {
  final TaskApi taskApi;
  final Ref ref;
  AddTaskNotifier(this.taskApi, this.ref) : super(States.noState());

  Future<bool> add(String idProject, TaskItem taskItem) async {
    state = States.loading();
    try {
      final response = await taskApi.createTask(idProject, taskItem);
      return response.fold(
        (error) {
          state = States.error(error);
          return false;
        },
        (data) {
          ref.watch(taskNotifier.notifier).getTasks(idProject);
          state = States.noState();
          return true;
        },
      );
    } catch (e) {
      state = States.error(exceptionTomessage(e));
      return false;
    }
  }
}

// update task
class UpdateTaskNotifier extends StateNotifier<States> {
  final TaskApi taskApi;
  UpdateTaskNotifier(this.taskApi) : super(States.noState());

  Future<Either<bool, bool>> updateTask(
      String taskId, TaskItem taskItem) async {
    state = States.loading();
    try {
      final response = await taskApi.updateTask(taskId, taskItem);
      return response.fold(
        (error) {
          state = States.error(error);
          return left(false);
        },
        (data) {
          state = States.noState();
          return right(true);
        },
      );
    } catch (e) {
      state = States.error(exceptionTomessage(e));
      return left(false);
    }
  }
}

// delete task
class DeleteTaskNotifier extends StateNotifier<States> {
  final TaskApi taskApi;
  DeleteTaskNotifier(this.taskApi) : super(States.noState());

  Future<Either<bool, bool>> deleteTask(String taskId) async {
    state = States.loading();
    try {
      final response = await taskApi.deleteTask(taskId);
      return response.fold(
        (error) {
          state = States.error(error);
          return left(false);
        },
        (data) {
          state = States.noState();
          return right(true);
        },
      );
    } catch (e) {
      state = States.error(exceptionTomessage(e));
      return left(false);
    }
  }
}
