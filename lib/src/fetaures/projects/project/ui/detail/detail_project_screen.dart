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
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _getData());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final stateProject = ref.watch(detailProjectNotifier);
    final project = stateProject.data;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () =>
                nextPage(context, "/project/form", argument: project),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                project?.name ?? "",
                textAlign: TextAlign.center,
                style: context.theme.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                project?.description ?? "",
                textAlign: TextAlign.center,
                style: context.theme.textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // SizedBox(
            //   height: size.height * 0.8,
            //   child: KanbanBoard(
            //     [
            //       BoardListsData(
            //         title: "TODO",
            //         header: const Text("TODO"),
            //         footer: const Text("Total: 0"),
            //         items: [],
            //       ),
            //       BoardListsData(
            //         title: "DOING",
            //         header: const Text("DOING"),
            //         footer: const Text("Total: 0"),
            //         items: [],
            //       ),
            //     ],
            //     onItemLongPress: (cardIndex, listIndex) {
            //       print("onItemLongPress $cardIndex, $listIndex");
            //     },
            //     onItemTap: (cardIndex, listIndex) {
            //       print("onItemTap $cardIndex, $listIndex");
            //     },
            //     onListTap: (listIndex) {
            //       print("onListTap $listIndex");
            //     },
            //     onListLongPress: (listIndex) {
            //       print("onListLongPress $listIndex");
            //     },
            //     onNewCardInsert: (cardIndex, listIndex, text) {
            //       print("onNewCardInsert $cardIndex, $listIndex, $text");
            //     },
            //   ),
            // ),
            // const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
