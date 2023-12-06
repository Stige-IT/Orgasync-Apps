part of "../../employee.dart";

class ButtonAddEmployee extends ConsumerStatefulWidget {
  final String companyId;
  const ButtonAddEmployee(
    this.companyId, {
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ButtonAddEmployeeState();
}

class _ButtonAddEmployeeState extends ConsumerState<ButtonAddEmployee> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      title: Text("add_employee".tr()),
      trailing: ElevatedButton.icon(
        icon: const Icon(Icons.add),
        label: Text("add".tr()),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: context.theme.colorScheme.tertiary.withOpacity(0.5),
          foregroundColor: context.theme.colorScheme.onSurface,
        ),
        onPressed: () =>
            nextPage(context, "/user/search", argument: widget.companyId),
      ),
    );
  }
}
