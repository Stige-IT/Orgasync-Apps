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
        child: Builder(builder: (_) {
          final employee = ref.watch(employeeCompanyNotifier);
          if (employee.isLoading) {
            return const Center(child: LoadingWidget());
          } else if (employee.error != null) {
            return ErrorButtonWidget(employee.error!, () => _getData());
          } else if (employee.data == null) {
            return const EmptyWidget();
          } else {
            return ListView.separated(
              padding: const EdgeInsets.all(10.0),
              itemCount: employee.data!.length,
              itemBuilder: (_, index) {
                final data = employee.data![index];
                return EmployeeItemWidget(data);
              },
              separatorBuilder: (_, __) => const SizedBox(height: 10),
            );
          }
        }),
      ),
    );
  }
}
