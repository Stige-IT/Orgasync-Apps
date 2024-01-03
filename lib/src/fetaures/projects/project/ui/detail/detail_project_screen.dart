part of "../../../project.dart";

class DetailProjectScreen extends ConsumerStatefulWidget {
  final String projectId;
  const DetailProjectScreen(this.projectId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailProjectScreenState();
}

class _DetailProjectScreenState extends ConsumerState<DetailProjectScreen> {
  void _getData() {
    ref.read(detailProjectNotifier.notifier).get(widget.projectId);
    ref.watch(taskNotifier.notifier).getTasks(widget.projectId);
    ref.watch(statusNotifier.notifier).getStatus();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _getData());
  }

  @override
  Widget build(BuildContext context) {
    final stateProject = ref.watch(detailProjectNotifier);
    final todo = ref.watch(taskNotifier).data?.todo;
    final doing = ref.watch(taskNotifier).data?.doing;
    final done = ref.watch(taskNotifier).data?.done;
    final project = stateProject.data;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          ConstantApp.appName.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                nextPage(context, "/project/form", argument: project),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: ListView(
        padding: context.isMobile
            ? const EdgeInsets.fromLTRB(0, 15.0, 0, 50.0)
            : const EdgeInsets.fromLTRB(50, 15.0, 50, 50.0),
        children: [
          const HeaderWidget(),
          SectionTask(
            "TODO",
            icon: Icons.assignment,
            data: todo ?? [],
            color: Colors.grey.withOpacity(.1),
          ),
          SectionTask(
            "DOING",
            icon: Icons.assignment_add,
            data: doing ?? [],
            color: Colors.yellow.withOpacity(.1),
          ),
          SectionTask(
            "DONE",
            icon: Icons.assignment_turned_in,
            data: done ?? [],
            color: Colors.green.withOpacity(.1),
          ),
        ],
      ),
    );
  }
}
