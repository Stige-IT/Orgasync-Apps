part of '../../../company.dart';

class DashboardMoreWidget extends ConsumerStatefulWidget {
  const DashboardMoreWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardMoreWidgetState();
}

class _DashboardMoreWidgetState extends ConsumerState<DashboardMoreWidget> {
  @override
  Widget build(BuildContext context) {
    final company = ref.watch(detailCompanyNotifier).data;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            ListTile(
                visualDensity: const VisualDensity(vertical: 4),
                leading: Builder(builder: (_) {
                  if (company?.logo != null) {
                    return CircleAvatarNetwork(company!.logo, size: 120);
                  } else {
                    return ProfileWithName(company?.name ?? "  ", size: 120);
                  }
                }),
                title: Text(
                  company?.name ?? "",
                  style: context.theme.textTheme.headlineSmall,
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(company?.code ?? ""),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(
                            const ClipboardData(text: "code copied"));
                        showSnackbar(context, "copied".tr());
                      },
                      icon: const Icon(Icons.copy),
                    )
                  ],
                )),
            const Divider(),
            const SizedBox(height: 20),
            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.location_city),
                title: Text("edit_company".tr()),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ),
            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.book),
                title: Text("logbook".tr()),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.toggle_off_outlined, size: 40),
                ),
                onTap: () {},
              ),
            ),
            const Spacer(),
            Card(
              child: ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: Text("remove_company".tr()),
                onTap: _handleDeleteCompany,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  void _handleDeleteCompany() {
    // alert dialog delete company
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("remove_company".tr()),
        content: Text("remove_company_content".tr()),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text("cancel".tr()),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              final idCompany = ref.watch(detailCompanyNotifier).data!.id;
              ref
                  .read(deleteCompanyNotifier.notifier)
                  .delete(idCompany!)
                  .then((success) {
                if (success) {
                  Navigator.of(context).pop();
                  showSnackbar(context, "delete_company_success".tr());
                } else {
                  final err = ref.watch(deleteCompanyNotifier).error;
                  showSnackbar(context, err!, type: SnackBarType.error);
                }
              });
            },
            child: Text("remove".tr()),
          ),
        ],
      ),
    );
  }
}
