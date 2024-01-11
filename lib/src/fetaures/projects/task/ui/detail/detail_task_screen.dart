part of "../../../project.dart";

class DetailTaskScreen extends ConsumerStatefulWidget {
  final String taskId;

  const DetailTaskScreen(this.taskId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailTaskScreenState();
}

class _DetailTaskScreenState extends ConsumerState<DetailTaskScreen> {
  late TextEditingController _titleCtrl;
  late TextEditingController _descriptionCtrl;

  Future _getData() async =>
      await ref.watch(detailTaskNotifier.notifier).getDetailTask(widget.taskId);

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController();
    _descriptionCtrl = TextEditingController();
    Future.microtask(() async {
      await _getData();
      final task = ref.watch(detailTaskNotifier).data;
      _titleCtrl.text = task?.title ?? "";
      _descriptionCtrl.text = task?.description ?? "";
    });

    _titleCtrl.addListener(() {
      if (_titleCtrl.text != ref.watch(detailTaskNotifier).data?.title) {
        ref.watch(titleIsUpdatedProvider.notifier).state = true;
      } else {
        ref.watch(titleIsUpdatedProvider.notifier).state = false;
      }
    });

    _descriptionCtrl.addListener(() {
      if (_descriptionCtrl.text !=
          ref.watch(detailTaskNotifier).data?.description) {
        ref.watch(descriptionIsUpdatedProvider.notifier).state = true;
      } else {
        ref.watch(descriptionIsUpdatedProvider.notifier).state = false;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _titleCtrl.dispose();
    _descriptionCtrl.dispose();
  }

  bool _isUpdatedTaskData() {
    if (ref.watch(selectedStatusProvider) != null ||
        ref.watch(selectedAssignedProvider) != null ||
        ref.watch(startDateProvider) != null ||
        ref.watch(endDateProvider) != null ||
        ref.watch(selectedPriorityProvider) != null ||
        ref.watch(titleIsUpdatedProvider) ||
        ref.watch(descriptionIsUpdatedProvider)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(statusNotifier).data;
    final priority = ref.watch(priorityNotifier).data;
    final members = ref.watch(memberCompanyProjectNotifier).data;
    final state = ref.watch(detailTaskNotifier);
    final task = state.data;
    final assignee = task?.assignee?.employee?.user;
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: context.isMobile ? size.width * .9 : size.width * .5,
          padding: const EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.background,
            border: Border.all(color: context.theme.colorScheme.onBackground),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Builder(builder: (context) {
            if (state.error != null) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ErrorButtonWidget(state.error!, () => _getData()),
                ],
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: FieldInput(
                      hintText: "title".tr(),
                      controllers: _titleCtrl,
                      borderActive: false,
                    ),
                    trailing: CircleAvatar(
                      child: IconButton(
                        onPressed: _handleDeleteTask,
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 20.0),
                  const Divider(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("created_by".tr()),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  leading: const Icon(Icons.person),
                                  title: Text(
                                    task?.createdBy?.employee?.user?.name ?? "",
                                  ),
                                ),
                                ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  leading: const Icon(
                                      Icons.supervised_user_circle_outlined),
                                  title: Text(
                                    task?.createdBy?.employee?.type?.name ?? "",
                                  ),
                                ),
                                ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  leading:
                                      const Icon(Icons.assignment_turned_in),
                                  title: Text(
                                    "${task?.createdAt?.timeFormat() ?? ""}",
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: Navigator.of(context).pop,
                                child: Text("close".tr()),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.person,
                        color: context.theme.colorScheme.onBackground,
                      ),
                      label: Text(
                        "created",
                        style: TextStyle(
                            color: context.theme.colorScheme.onBackground),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  LayoutBuilder(
                    builder: (_, constraint) => SizedBox(
                      width: constraint.maxWidth * .7,
                      child: Column(
                        children: [
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.assignment_turned_in),
                            title: Text(
                              "updated_by".tr(),
                              style: const TextStyle(fontSize: 16),
                            ),
                            subtitle:
                                Text("${task?.updatedAt?.timeFormat() ?? ""}"),
                            trailing: Text(
                                task?.updatedBy?.employee?.user?.name ?? ""),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.assignment),
                            title: Text("status".tr()),
                            trailing: PopupMenuButton(
                              itemBuilder: (_) => [
                                for (Status item in (status ?? []))
                                  PopupMenuItem(
                                    value: item,
                                    child: Text(item.name?.toUpperCase() ?? ""),
                                  ),
                              ],
                              child: Chip(
                                label: Builder(builder: (_) {
                                  if (ref.watch(selectedStatusProvider) !=
                                      null) {
                                    return Text(
                                      ref
                                              .watch(selectedStatusProvider)
                                              ?.name
                                              ?.toUpperCase() ??
                                          "",
                                    );
                                  }
                                  return Text(
                                    task?.status?.name?.toUpperCase() ?? "",
                                  );
                                }),
                              ),
                              onSelected: (value) {
                                ref
                                    .watch(selectedStatusProvider.notifier)
                                    .state = value;
                              },
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.flag),
                            title: Text("priority".tr()),
                            trailing: PopupMenuButton(
                              itemBuilder: (_) => [
                                for (Priority item in (priority ?? []))
                                  PopupMenuItem(
                                    value: item,
                                    child: Text(item.name?.toUpperCase() ?? ""),
                                  ),
                              ],
                              child: Chip(
                                label: Builder(builder: (_) {
                                  if (ref.watch(selectedPriorityProvider) !=
                                      null) {
                                    return Text(
                                      ref
                                              .watch(selectedPriorityProvider)
                                              ?.name
                                              ?.toUpperCase() ??
                                          "",
                                    );
                                  }
                                  return Text(
                                      task?.priority?.name?.toUpperCase() ??
                                          "");
                                }),
                              ),
                              onSelected: (value) {
                                ref
                                    .watch(selectedPriorityProvider.notifier)
                                    .state = value;
                              },
                            ),
                          ),

                          /// [*ASSIGNEE]
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.person),
                            title: Text("assignee".tr()),
                            trailing: PopupMenuButton(
                              itemBuilder: (_) => [
                                for (EmployeeCompanyProject member
                                    in (members ?? []))
                                  PopupMenuItem(
                                    value: member,
                                    child: Builder(builder: (_) {
                                      if (member.employee?.user?.image !=
                                          null) {
                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CircleAvatarNetwork(
                                              member.employee?.user?.image ??
                                                  "",
                                              size: 40,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              member.employee?.user?.name ?? "",
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ProfileWithName(
                                              member.employee?.user?.name ??
                                                  "  ",
                                              size: 40,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              member.employee?.user?.name ?? "",
                                            ),
                                          ],
                                        );
                                      }
                                    }),
                                  ),
                              ],
                              child: Builder(builder: (_) {
                                if (ref.watch(selectedAssignedProvider) !=
                                    null) {
                                  final assignee = ref
                                      .watch(selectedAssignedProvider)
                                      ?.employee
                                      ?.user;
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatarNetwork(
                                        assignee?.image ?? "",
                                        size: 40,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        assignee?.name?.firstNameFormatted ??
                                            "",
                                      ),
                                    ],
                                  );
                                } else {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Builder(builder: (_) {
                                        if (assignee?.image != null) {
                                          return CircleAvatarNetwork(
                                            assignee?.image ?? "",
                                            size: 40,
                                          );
                                        } else {
                                          return ProfileWithName(
                                            assignee?.name ?? "  ",
                                            size: 40,
                                          );
                                        }
                                      }),
                                      const SizedBox(width: 10),
                                      Text(
                                        assignee?.name?.firstNameFormatted ??
                                            "",
                                      ),
                                    ],
                                  );
                                }
                              }),
                              onSelected: (value) {
                                ref
                                    .watch(selectedAssignedProvider.notifier)
                                    .state = value;
                              },
                            ),
                          ),
                          ListTile(
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (date != null) {
                                ref.watch(startDateProvider.notifier).state =
                                    date.toString();
                              }
                            },
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.date_range),
                            title: Text("start_date".tr()),
                            trailing: Builder(builder: (_) {
                              if (ref.watch(startDateProvider) != null) {
                                return Text(
                                  ref.watch(startDateProvider)?.dateFormat() ??
                                      "-",
                                  style: context.theme.textTheme.bodySmall!
                                      .copyWith(fontWeight: FontWeight.bold),
                                );
                              }
                              return Text(
                                task?.startDate?.dateFormat() ?? "-",
                                style:
                                    context.theme.textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                          ),

                          ListTile(
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (date != null) {
                                ref.watch(endDateProvider.notifier).state =
                                    date.toString();
                              }
                            },
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.calendar_today),
                            title: Text("end_date".tr()),
                            trailing: Builder(builder: (_) {
                              if (ref.watch(endDateProvider) != null) {
                                return Text(
                                  ref.watch(endDateProvider)?.dateFormat() ??
                                      "-",
                                  style: context.theme.textTheme.bodySmall!
                                      .copyWith(fontWeight: FontWeight.bold),
                                );
                              }
                              return Text(
                                task?.endDate?.dateFormat() ?? "-",
                                style:
                                    context.theme.textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "description".tr(),
                      style: context.theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: FieldInput(
                      hintText: "description".tr(),
                      controllers: _descriptionCtrl,
                      borderActive: true,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  const SizedBox(height: 20),
                  LayoutBuilder(builder: (_, constraint) {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                          width: constraint.maxWidth * .7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "created_by".tr(),
                                style: context.theme.textTheme.bodySmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  AvatarProfile(
                                    size: 30,
                                    image:
                                        task?.updatedBy?.employee?.user?.image,
                                    name: task?.updatedBy?.employee?.user?.name,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    task?.updatedBy?.employee?.user?.name ?? "",
                                  ),
                                ],
                              ),
                              Text(
                                "${task?.updatedAt?.timeFormat() ?? ""}",
                                style:
                                    context.theme.textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          )),
                    );
                  }),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 100,
                        child: OutlinedButton(
                          onPressed: Navigator.of(context).pop,
                          child: Text("cancel".tr()),
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (_isUpdatedTaskData())
                        SizedBox(
                          width: 100,
                          child: FilledButton(
                            onPressed: _handleUpdateTask,
                            child: Text("update".tr()),
                          ),
                        ),
                    ],
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }

  void _handleUpdateTask() async {
    final taskData = ref.watch(detailTaskNotifier).data;
    String? assignee = ref.watch(selectedAssignedProvider)?.id;
    assignee ??= taskData?.assignee?.id;
    final newTaskData = TaskItem(
      id: taskData?.id,
      title: _titleCtrl.text,
      description: _descriptionCtrl.text,
      startDate: ref.watch(startDateProvider) ?? taskData?.startDate,
      endDate: ref.watch(endDateProvider) ?? taskData?.endDate,
      status: ref.watch(selectedStatusProvider) ?? taskData?.status,
      priority: ref.watch(selectedPriorityProvider) ?? taskData?.priority,
      assignee: Assignee(id: assignee),
    );

    final result = await ref
        .watch(updateTaskNotifier.notifier)
        .updateTask(widget.taskId, newTaskData);

    result.fold(
      (error) {
        final error = ref.watch(updateTaskNotifier).error!;
        showSnackbar(context, error, type: SnackBarType.error);
      },
      (success) {
        showSnackbar(context, "success".tr());
        Navigator.of(context).pop();
        final projectId = ref.watch(detailProjectNotifier).data?.id;
        ref.watch(taskNotifier.notifier).getTasks(projectId!);
      },
    );
  }

  void _handleDeleteTask() {
    // dialog confirm delete
    // Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("delete_task".tr()),
        content: Text("confirm_delete_task".tr()),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text("cancel".tr()),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final result = await ref
                  .watch(deleteTaskNotifier.notifier)
                  .deleteTask(widget.taskId);
              result.fold(
                (error) {
                  final error = ref.watch(deleteTaskNotifier).error;
                  showSnackbar(context, error!, type: SnackBarType.error);
                },
                (success) {
                  showSnackbar(context, "success".tr());
                  final projectId = ref.watch(detailProjectNotifier).data?.id;
                  ref.watch(taskNotifier.notifier).getTasks(projectId!);
                  Navigator.of(context).pop();
                },
              );
            },
            child: Text("delete".tr()),
          ),
        ],
      ),
    );
  }
}
