part of "../../../project.dart";

class ListEmployeeProjectScreen extends ConsumerStatefulWidget {
  const ListEmployeeProjectScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListEmployeeProjectScreenState();
}

class _ListEmployeeProjectScreenState
    extends ConsumerState<ListEmployeeProjectScreen> {
  late ScrollController _scrollController;

  void _getData() {
    final idCompanyProject =
        ref.watch(detailCompanyProjectNotifier).data!.companyProject!.id;
    ref.read(memberCompanyProjectNotifier.notifier).refresh(idCompanyProject!);
  }

  @override
  void initState() {
    super.initState();
    // Future.microtask(() => _getData());
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          final idCompanyProject =
              ref.watch(detailCompanyProjectNotifier).data!.companyProject!.id;
          ref
              .read(memberCompanyProjectNotifier.notifier)
              .loadMore(idCompanyProject!);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final roleUser = ref.watch(roleInCompanyNotifier).data;
    final membersProject = ref.watch(memberCompanyProjectNotifier);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: GestureDetector(
          onTap: () => _getData(),
          child: Text("employee_project".tr()),
        ),
        actions: [
          if (roleUser == Role.owner)
            IconButton(
              onPressed: () =>
                  nextPage(context, "/company/project/employee/add"),
              icon: const Icon(Icons.person_add_alt),
            ),
          const SizedBox(width: 20),
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(minWidth: 0, maxWidth: 1024),
          child: Builder(builder: (_) {
            if (membersProject.isLoading) {
              return const Center(child: LoadingWidget());
            } else if (membersProject.error != null) {
              return ErrorButtonWidget(membersProject.error!, () => _getData());
            } else if (membersProject.data == null ||
                membersProject.data!.isEmpty) {
              return const EmptyWidget();
            } else {
              return ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.all(15.0),
                itemBuilder: (_, i) {
                  if (membersProject.isLoadingMore &&
                      i == membersProject.data!.length) {
                    return const Center(child: LoadingWidget());
                  }
                  final employee = membersProject.data![i];
                  return Dismissible(
                    key: Key(employee.id!),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 15.0),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: roleUser == Role.owner
                        ? DismissDirection.endToStart
                        : DismissDirection.none,
                    confirmDismiss: (_) => _handleDismiss(employee),
                    child: Card(
                      child: ListTile(
                          onTap: () {},
                          leading: Builder(builder: (_) {
                            if (employee.employee?.user?.image != null) {
                              return CircleAvatarNetwork(
                                  employee.employee!.user!.image!);
                            } else {
                              return ProfileWithName(
                                  employee.employee?.user?.name ?? "  ");
                            }
                          }),
                          title: Text(employee.employee?.user?.name ?? ""),
                          subtitle: Text(employee.employee?.user?.email ?? ""),
                          trailing: roleUser == Role.owner
                              ? PopupMenuButton(
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: "delete",
                                      child: Text("delete".tr()),
                                    ),
                                  ],
                                  onSelected: (value) {
                                    if (value == "delete") {
                                      _handleDismiss(employee);
                                    }
                                  },
                                )
                              : null),
                    ),
                  );
                },
                separatorBuilder: (_, i) => const Divider(),
                itemCount: membersProject.isLoadingMore
                    ? (membersProject.data ?? []).length + 1
                    : membersProject.data?.length ?? 0,
              );
            }
          }),
        ),
      ),
    );
  }

  _handleDismiss(EmployeeCompanyProject data) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "delete_employee".tr(),
          style: context.theme.textTheme.titleLarge,
        ),
        content: Text(
          "delete_employee_message"
              .tr(namedArgs: {"name": data.employee!.user!.name!}),
          style: context.theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("cancel".tr()),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              final idCompanyProject = ref
                  .watch(detailCompanyProjectNotifier)
                  .data!
                  .companyProject!
                  .id;
              ref
                  .read(memberCompanyProjectNotifier.notifier)
                  .removeMember(idCompanyProject!, data.id!)
                  .then((success) {
                if (success) {
                  showSnackbar(context, "delete_employee_success".tr());
                  return true;
                } else {
                  final err = ref.watch(memberCompanyProjectNotifier).error;
                  showSnackbar(context, err!, type: SnackBarType.error);
                  return false;
                }
              });
            },
            child: Text("delete".tr()),
          ),
        ],
      ),
    );
  }
}
