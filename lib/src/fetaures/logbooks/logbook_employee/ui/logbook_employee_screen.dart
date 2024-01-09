part of "../logbook_employee.dart";

class LogBookEmployeeScreen extends ConsumerStatefulWidget {
  final String idLogbook;
  const LogBookEmployeeScreen(this.idLogbook, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      LogBookEmployeeScreenState();
}

class LogBookEmployeeScreenState extends ConsumerState<LogBookEmployeeScreen> {
  late ScrollController _scrollController;

  void _getData() {
    ref.read(logBookEmployeeNotifier.notifier).refresh(widget.idLogbook);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _getData());
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          ref
              .read(logBookEmployeeNotifier.notifier)
              .isLoadMore(widget.idLogbook);
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  bool employeeJoined(String id) {
    final selectedEmployee = ref.watch(selectedlogBookEmployeeProvider);
    return selectedEmployee.any((e) => e.id == id);
  }

  @override
  Widget build(BuildContext context) {
    final employeeState = ref.watch(logBookEmployeeNotifier);
    final employeeData = employeeState.data;
    final selectedEmployee = ref.watch(selectedlogBookEmployeeProvider);
    return Builder(builder: (_) {
      if (employeeState.isLoading) {
        return const Center(child: LoadingWidget());
      } else if (employeeState.error != null) {
        return Center(
          child: ErrorButtonWidget(employeeState.error!, () => _getData()),
        );
      } else if (employeeData == null || employeeData.isEmpty) {
        return const Center(child: EmptyWidget());
      } else {
        return Expanded(
          child: Column(
            children: [
              if (selectedEmployee.isNotEmpty)
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text("${selectedEmployee.length} selected"),
                  trailing: TextButton.icon(
                    onPressed: () => _handleDismiss(selectedEmployee),
                    icon: const Icon(Icons.delete, color: Colors.red),
                    label: Text("delete".tr()),
                  ),
                ),
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: employeeState.isLoadingMore
                      ? employeeData.length + 1
                      : employeeData.length,
                  itemBuilder: (_, index) {
                    if (employeeState.isLoadingMore &&
                        index == employeeData.length) {
                      return const Center(child: LoadingWidget());
                    } else {
                      final employee = employeeData[index];
                      return Dismissible(
                        key: Key(employee.id!),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (_) => _handleDismiss([employee]),
                        background: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          trailing: const Icon(Icons.delete),
                          tileColor: context.theme.colorScheme.error,
                        ),
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: employeeJoined(employee.id!)
                                ? BorderSide(
                                    color:
                                        context.theme.colorScheme.onBackground,
                                  )
                                : BorderSide.none,
                          ),
                          child: ListTile(
                            onLongPress: () => _handleLogPress(employee),
                            onTap: () => nextPage(context, "/activity",
                                argument: employee.id),
                            leading: AvatarProfile(
                                image: employee.employee?.user?.image,
                                name: employee.employee?.user?.name ?? ""),
                            title: Text(employee.employee?.user?.name ?? ""),
                            subtitle:
                                Text(employee.employee?.user?.email ?? ""),
                            trailing: Column(
                              children: [
                                const Text("Total Activity "),
                                Text(
                                  "${employee.totalActivity ?? 0}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  separatorBuilder: (_, i) => const Divider(),
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  void _handleLogPress(LogBookEmployee employee) {
    if (employeeJoined(employee.id!)) {
      ref.read(selectedlogBookEmployeeProvider.notifier).remove(employee);
    } else {
      ref.read(selectedlogBookEmployeeProvider.notifier).add(employee);
    }
  }

  _handleDismiss(List<LogBookEmployee> data) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "delete_employee".tr(),
          style: context.theme.textTheme.titleLarge,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("cancel".tr()),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();

              /// delete employee
              ref
                  .read(removeLogBookEmployeeNotifier.notifier)
                  .delete(widget.idLogbook,
                      idLogBookEmployee: data.map((e) => e.id!).toList())
                  .then((success) {
                ref.invalidate(selectedlogBookEmployeeProvider);
                if (!success) {
                  final err = ref.watch(removeLogBookEmployeeNotifier).error!;
                  showSnackbar(context, err, type: SnackBarType.error);
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
