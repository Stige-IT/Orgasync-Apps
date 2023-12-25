part of "../../project.dart";

// get project by company project id using stateNotifier with States<List<Project>>
class ProjectsNotifier extends StateNotifier<States<List<Project>>> {
  final ProjectImpl _projectImpl;
  ProjectsNotifier(this._projectImpl) : super(States.noState());

  Future<void> get(String companyProjectId) async {
    state = States.loading();
    try {
      final result = await _projectImpl.getProjects(companyProjectId);
      result.fold(
        (error) => state = States.error(error),
        (response) => state = States.finished(response),
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
    }
  }
}

// detail project with States<Project>
class DetailProjectNotifier extends StateNotifier<States<Project>> {
  final ProjectImpl _projectImpl;
  DetailProjectNotifier(this._projectImpl) : super(States.noState());

  Future<void> get(String idProject) async {
    state = States.loading();
    try {
      final result = await _projectImpl.detailProject(idProject);
      result.fold(
        (error) => state = States.error(error),
        (response) => state = States.finished(response),
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
    }
  }
}

// create new project using stateNotifier with States<bool>
class CreateProjectNotifier extends StateNotifier<States<bool>> {
  final ProjectImpl _projectImpl;
  final Ref ref;
  CreateProjectNotifier(this._projectImpl, this.ref) : super(States.noState());

  Future<bool> create(
      String companyProjectId, String name, String description) async {
    state = States.loading();
    try {
      final result = await _projectImpl.createProject(companyProjectId,
          name: name, description: description);
      return result.fold(
        (error) {
          state = States.error(error);
          return false;
        },
        (response) {
          state = States.finished(response);
          ref.read(projectsNotifier.notifier).get(companyProjectId);
          ref.read(detailCompanyProjectNotifier.notifier).get(companyProjectId);
          return true;
        },
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
      return false;
    }
  }
}

// update project
class UpdateProjectNotifier extends StateNotifier<States<bool>> {
  final ProjectImpl _projectImpl;
  final Ref ref;
  UpdateProjectNotifier(this._projectImpl, this.ref) : super(States.noState());

  Future<bool> update(String idProject, String name, String description) async {
    state = States.loading();
    try {
      final result = await _projectImpl.updateProject(
        idProject,
        name: name,
        description: description,
      );
      return result.fold(
        (error) {
          state = States.error(error);
          return false;
        },
        (response) {
          state = States.noState();
          ref.read(detailProjectNotifier.notifier).get(idProject);
          // ref.read(detailCompanyProjectNotifier.notifier).get(idProject);
          return true;
        },
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
      return false;
    }
  }
}

// delete project using stateNotifier with States<bool>
class DeleteProjectNotifier extends StateNotifier<States<bool>> {
  final ProjectImpl _projectImpl;
  final Ref ref;
  DeleteProjectNotifier(this._projectImpl, this.ref) : super(States.noState());

  Future<bool> delete(String idProject, String companyProjectId) async {
    state = States.loading();
    try {
      final result = await _projectImpl.deleteProject(idProject);
      return result.fold(
        (error) {
          state = States.error(error);
          return false;
        },
        (response) {
          state = States.finished(response);
          ref.read(projectsNotifier.notifier).get(companyProjectId);
          ref.read(detailCompanyProjectNotifier.notifier).get(companyProjectId);
          return true;
        },
      );
    } catch (exception) {
      state = States.error(exceptionTomessage(exception));
      return false;
    }
  }
}
