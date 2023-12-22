part of "../../project.dart";

class ProjectScreen extends ConsumerStatefulWidget {
  const ProjectScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends ConsumerState<ProjectScreen> {
  void _getData() {
    final companyProjectId =
        ref.read(detailCompanyProjectNotifier).data?.companyProject?.id;
    if (companyProjectId != null) {
      ref.read(projectsNotifier.notifier).get(companyProjectId);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _getData());
  }

  @override
  Widget build(BuildContext context) {
    final projects = ref.watch(projectsNotifier);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text("project".tr()),
        actions: [
          IconButton(
            onPressed: () => nextPage(context, "/project/form"),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1), () => _getData());
        },
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(15.0),
                itemCount: projects.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final project = projects.data?[index];
                  return CardProject(project);
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
