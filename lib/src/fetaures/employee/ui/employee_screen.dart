part of "../employee.dart";

class EmployeeScreen extends ConsumerStatefulWidget {
  final String companyId;
  const EmployeeScreen(this.companyId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends ConsumerState<EmployeeScreen> {
  void _getData() {
    ref.read(employeeCompanyNotifier.notifier).refresh(widget.companyId);
  }

  @override
  Widget build(BuildContext context) {
    final role = ref.watch(roleInCompanyNotifier).data;
    final me = ref.watch(userNotifier).data;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.colorScheme.background,
        foregroundColor: context.theme.colorScheme.onSurfaceVariant,
        centerTitle: true,
        title: Text(
          "employee".tr(),
          style: context.theme.textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2), () => _getData());
        },
        child: Column(
          children: [
            if (role == Role.owner) ButtonAddEmployee(widget.companyId),
            Builder(builder: (_) {
              final employee = ref.watch(employeeCompanyNotifier);
              if (employee.isLoading) {
                return const Center(child: LoadingWidget());
              } else if (employee.error != null) {
                return ErrorButtonWidget(employee.error!, () => _getData());
              } else if (employee.data == null) {
                return const EmptyWidget();
              } else {
                return Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: employee.data!.length,
                    itemBuilder: (_, index) {
                      final data = employee.data![index];
                      return Dismissible(
                        key: Key(data.id!),
                        // if me user is owner, then can delete employee
                        direction: data.user!.id == me!.id || role != Role.owner
                            ? DismissDirection.none
                            : DismissDirection.endToStart,
                        confirmDismiss: (_) => _handleDismiss(data),
                        background: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          trailing: const Icon(Icons.delete),
                          tileColor: context.theme.colorScheme.error,
                        ),
                        child: EmployeeItemWidget(data),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  _handleDismiss(Employee data) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "delete_employee".tr(),
          style: context.theme.textTheme.titleLarge,
        ),
        content: Text(
          "delete_employee_message".tr(namedArgs: {"name": data.user!.name!}),
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
              ref
                  .read(deleteEmployeeNotifier.notifier)
                  .delete(data.id!, widget.companyId)
                  .then((success) {
                if (success) {
                  showSnackbar(context, "delete_employee_success".tr(),
                      type: SnackBarType.success);
                  return true;
                } else {
                  final errMessage = ref.watch(deleteEmployeeNotifier).error;
                  showSnackbar(context, errMessage!, type: SnackBarType.error);
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
