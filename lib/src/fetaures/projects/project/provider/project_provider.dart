part of "../../project.dart";

// get project by compnay project id
final projectsNotifier =
    StateNotifierProvider<ProjectsNotifier, States<List<Project>>>((ref) {
  return ProjectsNotifier(ref.watch(projectProvider));
});

// detail project
final detailProjectNotifier =
    StateNotifierProvider<DetailProjectNotifier, States<Project>>((ref) {
  return DetailProjectNotifier(ref.watch(projectProvider));
});

// create new project
final createProjectNotifier =
    StateNotifierProvider<CreateProjectNotifier, States<bool>>((ref) {
  return CreateProjectNotifier(ref.watch(projectProvider), ref);
});

// update project
final updateProjectNotifier =
    StateNotifierProvider<UpdateProjectNotifier, States<bool>>((ref) {
  return UpdateProjectNotifier(ref.watch(projectProvider), ref);
});

// delete project
final deleteProjectNotifier =
    StateNotifierProvider<DeleteProjectNotifier, States<bool>>((ref) {
  return DeleteProjectNotifier(ref.watch(projectProvider), ref);
});
