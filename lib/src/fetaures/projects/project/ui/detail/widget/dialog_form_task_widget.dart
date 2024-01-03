part of "../../../../project.dart";

class DialogAddTaskWidget extends ConsumerStatefulWidget {
  final TaskItem? taskItem;
  const DialogAddTaskWidget({super.key, this.taskItem});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DialogAddTaskWidgetState();
}

class _DialogAddTaskWidgetState extends ConsumerState<DialogAddTaskWidget> {
  late TextEditingController _titleCtrl;
  late TextEditingController _descriptionCtrl;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController();
    _descriptionCtrl = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _titleCtrl.dispose();
    _descriptionCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final idProject = ref.watch(detailProjectNotifier).data?.id;
    final employee = ref.watch(memberCompanyProjectNotifier).data;
    final priorities = ref.watch(priorityNotifier).data;
    final startDate = ref.watch(startDateProvider);
    final endDate = ref.watch(endDateProvider);
    final size = MediaQuery.sizeOf(context);
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(15.0),
          // height: MediaQuery.sizeOf(context).width * .8,
          width: context.isMobile ? size.width * .95 : size.width * .5,
          decoration: BoxDecoration(
            border: Border.all(
              color: context.theme.colorScheme.onBackground,
            ),
            color: context.theme.colorScheme.background,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.zero,
                  title: Text("add_task".tr()),
                  trailing: IconButton(
                    onPressed: Navigator.of(context).pop,
                    icon: const Icon(Icons.close),
                  ),
                ),
                const Divider(),
                FieldInput(
                  title: "title".tr(),
                  hintText: "input_title".tr(),
                  controllers: _titleCtrl,
                ),
                FieldInput(
                  title: "description".tr(),
                  hintText: "input_description".tr(),
                  controllers: _descriptionCtrl,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                ),
                DropdownContainer(
                  title: "assigneed".tr(),
                  value: ref.watch(selectedAssignedProvider),
                  items: (employee ?? [])
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: context.theme.colorScheme.onBackground,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            leading: Builder(builder: (_) {
                              if (e.employee?.user?.image != null) {
                                return CircleAvatarNetwork(
                                    e.employee!.user!.image!);
                              } else {
                                return ProfileWithName(
                                    e.employee?.user?.name ?? "  ");
                              }
                            }),
                            title: Text(
                              e.employee?.user?.name ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              e.employee?.user?.email ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )))
                      .toList(),
                  onChanged: (value) {
                    ref.watch(selectedAssignedProvider.notifier).state = value;
                  },
                ),
                DropdownContainer(
                  title: "priority".tr(),
                  value: ref.watch(selectedPriorityProvider),
                  items: (priorities ?? []).map((e) {
                    return DropdownMenuItem(
                        value: e, child: Text(e.name ?? ""));
                  }).toList(),
                  onChanged: (value) {
                    ref.watch(selectedPriorityProvider.notifier).state = value;
                  },
                ),
                const SizedBox(height: 20),
                ListTile(
                  dense: true,
                  title: Text("start_date".tr()),
                  subtitle:
                      Text(startDate?.toString().dateFormatWithDay() ?? ''),
                  trailing: IconButton(
                    onPressed: () async {
                      final newDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (newDate != null) {
                        ref.watch(startDateProvider.notifier).state =
                            newDate.toString();
                      }
                    },
                    icon: const Icon(Icons.date_range),
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  dense: true,
                  title: Text("end_date".tr()),
                  subtitle: Text(endDate?.toString().dateFormatWithDay() ?? ''),
                  trailing: IconButton(
                    onPressed: () async {
                      final newDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );

                      if (newDate != null) {
                        ref.watch(endDateProvider.notifier).state =
                            newDate.toString();
                      }
                    },
                    icon: const Icon(Icons.calendar_today_rounded),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 100,
                    child: FilledButton(
                      onPressed: () {
                        final title = _titleCtrl.text;
                        final description = _descriptionCtrl.text;
                        final assignee = ref.watch(selectedAssignedProvider);
                        final priority = ref.watch(selectedPriorityProvider);
                        final startDate = ref.watch(startDateProvider);
                        final endDate = ref.watch(endDateProvider);
                        final requestTaskItem = TaskItem(
                          title: title,
                          description: description,
                          assignee: Assignee(
                            id: assignee?.id,
                            employee: assignee?.employee,
                          ),
                          priority: priority,
                          startDate: startDate,
                          endDate: endDate,
                        );
                        ref
                            .read(addTaskNotifier.notifier)
                            .add(idProject!, requestTaskItem)
                            .then((success) {
                          if (success) {
                            Navigator.of(context).pop();
                          } else {
                            final err = ref.watch(addTaskNotifier).error!;
                            showSnackbar(context, err,
                                type: SnackBarType.error);
                          }
                        });
                      },
                      child: Text("add".tr()),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
