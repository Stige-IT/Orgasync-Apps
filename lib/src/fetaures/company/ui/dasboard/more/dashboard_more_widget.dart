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
            Card(
              child: ListTile(
                leading: Builder(builder: (_) {
                  if (company?.logo != null) {
                    return CircleAvatarNetwork(company!.logo, size: 40);
                  } else {
                    return ProfileWithName(company?.name ?? "  ", size: 40);
                  }
                }),
                title: Text(company?.name ?? ""),
                subtitle: TextButton.icon(
                  style: TextButton.styleFrom(alignment: Alignment.centerLeft),
                  label: Text(company?.code ?? ""),
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(const ClipboardData(text: "code copied"));
                    showSnackbar(context, "copied".tr());
                  },
                ),
              ),
              // create list title delete company
            ),
            const Spacer(),
            Card(
              child: ListTile(
                leading: const Icon(Icons.disabled_by_default_outlined),
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
