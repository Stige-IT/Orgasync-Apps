part of "../../project.dart";

class CompanyProjectScreen extends ConsumerStatefulWidget {
  final String companyId;
  const CompanyProjectScreen(this.companyId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompanyProjectScreenState();
}

class _CompanyProjectScreenState extends ConsumerState<CompanyProjectScreen> {
  void _getData() {
    ref.read(companyProjectNotifier.notifier).refresh(widget.companyId);
  }

  @override
  void initState() {
    Future.microtask(() => _getData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final roleUser = ref.watch(roleInCompanyNotifier).data;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.colorScheme.background,
        foregroundColor: context.theme.colorScheme.onSurfaceVariant,
        centerTitle: true,
        title: InkWell(
          onTap: () => _getData(),
          child: Text(
            "project".tr(),
            style: context.theme.textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(minWidth: 0, maxWidth: 1024),
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(
                  const Duration(seconds: 2), () => _getData());
            },
            child: Builder(builder: (_) {
              final project = ref.watch(companyProjectNotifier);
              if (project.isLoading) {
                return const Center(child: LoadingWidget());
              } else if (project.error != null) {
                return ErrorButtonWidget(project.error!, () => _getData());
              } else if (project.data == null || project.data!.isEmpty) {
                return const EmptyWidget();
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 100.0),
                  itemCount: project.data!.length,
                  itemBuilder: (_, index) {
                    final data = project.data![index];
                    return InkWell(
                        onTap: () {
                          nextPage(context, "/company/project/detail",
                              argument: data.id);
                        },
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Delete Project"),
                              content: const Text(
                                  "Are you sure want to delete this project?"),
                              actions: [
                                TextButton(
                                  onPressed: Navigator.of(context).pop,
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    ref
                                        .read(deleteCompanyProjectNotifier
                                            .notifier)
                                        .delete(widget.companyId, data.id!);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Delete"),
                                ),
                              ],
                            ),
                          );
                        },
                        child: ProjectItemWidget(data));
                  },
                );
              }
            }),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: roleUser == Role.owner
          ? FloatingActionButton(
              onPressed: () => nextPage(context, "/company/project/form"),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
