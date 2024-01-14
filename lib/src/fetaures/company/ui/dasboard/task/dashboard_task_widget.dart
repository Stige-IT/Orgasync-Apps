part of '../../../company.dart';

class DashboardTaskWidget extends ConsumerStatefulWidget {
  final String companyId;
  const DashboardTaskWidget(this.companyId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardTaskWidgetState();
}

class _DashboardTaskWidgetState extends ConsumerState<DashboardTaskWidget> {
  void _getData() {
    ref.watch(taskMeNotifier.notifier).get(widget.companyId);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _getData());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(taskMeNotifier);
    final data = state.data;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: InkWell(onTap: () => _getData(), child: Text("Task".tr())),
        ),
        body: Builder(builder: (_) {
          if (state.isLoading) {
            return const Center(child: LoadingWidget());
          } else if (state.error != null) {
            return ErrorButtonWidget(state.error!, () => _getData());
          } else if (data == null || data.isEmpty) {
            return const Center(child: EmptyWidget());
          } else {
            return ListView.separated(
              itemBuilder: (_, i) {
                final project = data[i];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: context.theme.colorScheme.onBackground
                          .withOpacity(0.5),
                    ),
                  ),
                  child: ExpansionTile(
                    title: Text(project.nameProject ?? ""),
                    subtitle: Text(project.descriptionProject ?? ""),
                    children: [
                      for (TaskItem task in project.task ?? [])
                        Card(
                          margin: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                              color: context.theme.colorScheme.onBackground
                                  .withOpacity(0.2),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                onTap: () {
                                  nextPage(
                                    context,
                                    "/company/project",
                                    argument: widget.companyId,
                                  );
                                  nextPage(
                                    context,
                                    "/company/project/detail",
                                    argument: project.idCompanyProject,
                                  );
                                  nextPage(
                                    context,
                                    "/project/detail",
                                    argument: project.idProject,
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (_) => DetailTaskScreen(task.id!),
                                  );
                                },
                                leading: const Icon(Icons.assignment_add),
                                title: Text(task.title ?? ""),
                                subtitle: Text(task.description ?? ""),
                                trailing: Chip(
                                  color: MaterialStatePropertyAll(
                                    ColorUtils.stringToColor(
                                        "${task.status?.color}"),
                                  ),
                                  label: Text(task.status?.name ?? ""),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      "${task.startDate?.dateFormat() ?? ''} - ${task.endDate?.dateFormat() ?? ''}"),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, i) => const SizedBox(height: 15),
              itemCount: data.length,
            );
          }
        }));
  }
}
