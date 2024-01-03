part of "../../../../project.dart";

class SectionTask extends ConsumerWidget {
  final IconData icon;
  final String sectionName;
  final List<TaskItem> data;
  final Color color;
  const SectionTask(
    this.sectionName, {
    super.key,
    required this.data,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context, ref) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: ExpansionTile(
        backgroundColor: color,
        initiallyExpanded: true,
        leading: Icon(icon),
        childrenPadding: const EdgeInsets.symmetric(vertical: 10.0),
        title: Text("$sectionName (${data.length})"),
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: context.isMobile ? null : size.width,
              child: Card(
                elevation: 2,
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.all(5.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: DataTable(
                    dataRowColor: MaterialStateProperty.all(
                      context.theme.colorScheme.background,
                    ),
                    headingRowColor: MaterialStateProperty.all(
                      context.theme.colorScheme.background,
                    ),
                    showCheckboxColumn: false,
                    dataRowMinHeight: 20,
                    dataRowMaxHeight: 70,
                    columns: const [
                      DataColumn(label: Text("Name")),
                      DataColumn(label: Text("Status")),
                      DataColumn(label: Text("Assigneed")),
                      DataColumn(label: Text("priority")),
                      DataColumn(label: Text("start date")),
                      DataColumn(label: Text("end date")),
                    ],
                    rows: data.map((e) {
                      return rowItems(context, e, ref);
                    }).toList()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow rowItems(
    BuildContext context,
    TaskItem e,
    WidgetRef ref,
  ) {
    final status = ref.watch(statusNotifier).data;
    final employee = ref.watch(memberCompanyProjectNotifier).data;
    return DataRow(
      onLongPress: () {
        // dialog confirm delete
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Delete Task"),
            content: const Text("Are you sure want to delete this task?"),
            actions: [
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ref.read(taskNotifier.notifier).removeTask(e).then((success) {
                    if (!success) {
                      final err = ref.watch(updateTaskNotifier).error!;
                      showSnackbar(context, err, type: SnackBarType.error);
                    }
                  });
                },
                child: const Text("Delete"),
              ),
            ],
          ),
        );
      },
      onSelectChanged: (value) =>
          showDialog(context: context, builder: (_) => DetailTaskScreen(e.id!)),
      cells: [
        DataCell(Container(
          constraints: BoxConstraints(maxWidth: context.isMobile ? 150 : 300),
          child: Text(
            e.title ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        )),

        ///[* Status *]
        DataCell(PopupMenuButton<Status>(
          tooltip: "Choose status",
          itemBuilder: (_) =>
              status?.map((e) {
                return PopupMenuItem(
                  value: e,
                  child: Text(e.name?.toUpperCase() ?? ""),
                );
              }).toList() ??
              [],
          onSelected: (value) {
            if (value.name != e.status?.name) {
              ref
                  .read(taskNotifier.notifier)
                  .changeStatus(e, value)
                  .then((success) {
                if (!success) {
                  final err = ref.watch(updateTaskNotifier).error!;
                  showSnackbar(context, err, type: SnackBarType.error);
                }
              });
            }
          },
          child: Chip(
            label: Text(e.status?.name?.toUpperCase() ?? ""),
          ),
        )),

        ///[* Assignee *]
        DataCell(
          PopupMenuButton<EmployeeCompanyProject>(
            tooltip: "Choose employee",
            onSelected: (value) {
              ref
                  .watch(taskNotifier.notifier)
                  .changeAssigned(e, value)
                  .then((success) {
                if (!success) {
                  final err = ref.watch(updateTaskNotifier).error!;
                  showSnackbar(context, err, type: SnackBarType.error);
                }
              });
            },
            itemBuilder: (_) =>
                employee?.map((e) {
                  return PopupMenuItem(
                    value: e,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ListTile(
                        leading: Builder(builder: (_) {
                          if (e.employee?.user?.image == null) {
                            return ProfileWithName(
                                e.employee?.user?.name ?? "  ",
                                size: 40);
                          }
                          return CircleAvatarNetwork(e.employee?.user?.image,
                              size: 40);
                        }),
                        title: Text(
                          e.employee?.user?.name ?? "",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  );
                }).toList() ??
                [],
            child: Row(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Builder(builder: (_) {
                        if (e.assignee != null) {
                          final name = e.assignee?.employee?.user?.name;
                          if (e.assignee!.employee?.user?.image != null) {
                            final image = e.assignee!.employee!.user!.image!;
                            return CircleAvatarNetwork(image);
                          } else {
                            return ProfileWithName(name ?? "  ");
                          }
                        }
                        return const CircleAvatar(
                          radius: 25,
                          child: Icon(Icons.person),
                        );
                      }),
                    ),
                    if (e.assignee != null)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            // remove assignee
                            ref
                                .read(taskNotifier.notifier)
                                .removeAssigned(e)
                                .then((success) {
                              if (!success) {
                                final err =
                                    ref.watch(updateTaskNotifier).error!;
                                showSnackbar(context, err,
                                    type: SnackBarType.error);
                              }
                            });
                          },
                          child: const CircleAvatar(
                            radius: 10,
                            child: Icon(Icons.close, size: 10),
                          ),
                        ),
                      )
                  ],
                ),
                SizedBox(width: context.isMobile ? 5 : 10),
                if (context.isDesktop)
                  Text(
                    e.assignee?.employee?.user?.name ?? "-",
                    style: const TextStyle(fontSize: 12),
                  ),
              ],
            ),
          ),
        ),

        ///[* Priority *]
        DataCell(Text(e.priority?.name ?? "-")),

        ///[* Start Date *]
        DataCell(ListTile(
          onTap: () {
            log("start date");
          },
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          leading: const Icon(Icons.date_range),
          title: Text(
            e.startDate?.dateFormat() ?? "-",
            style: const TextStyle(color: Colors.green, fontSize: 10),
          ),
        )),

        ///[* End Date *]
        DataCell(ListTile(
          onTap: () {
            log("end date");
          },
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          leading: const Icon(Icons.date_range_outlined),
          title: Text(e.endDate?.dateFormat() ?? "-",
              style: const TextStyle(color: Colors.red, fontSize: 10)),
        )),
      ],
    );
  }
}
