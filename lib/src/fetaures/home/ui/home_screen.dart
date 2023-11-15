part of "../home.dart";

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late TextEditingController _codeCompanyCtrl;

  void _getData() {
    ref.read(roleNotifier.notifier).getRole();
  }

  @override
  void initState() {
    _codeCompanyCtrl = TextEditingController();
    Future.microtask(() => _getData());
    super.initState();
  }

  @override
  void dispose() {
    _codeCompanyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: context.height * 0.1,
          backgroundColor: Colors.transparent,
          // leading: Image.asset("assets/images/app_logo.png"),
          title: Text(
            "app_name".tr(),
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              onPressed: () {
                ref.read(storageProvider).delete("token");
                nextPageRemoveAll(context, "/login");
              },
              icon: const Icon(Icons.logout),
            ),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.notifications_none)),
            CircleAvatar(
              radius: 25,
              backgroundImage: const AssetImage("assets/images/profile.png"),
              backgroundColor: context.theme.colorScheme.background,
            ),
            const SizedBox(width: 20),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1), () {
              ref.read(companyNotifier.notifier).refresh();
            });
          },
          child: const CompaniesWidget(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _handleJoinCompany,
          child: const Icon(Icons.add),
        ));
  }

  void _handleJoinCompany() {
    _codeCompanyCtrl.clear();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Company"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FieldInput(
              textAlign: TextAlign.center,
              hintText: "Masukkan kode perusahaan",
              controllers: _codeCompanyCtrl,
            ),
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref
                  .read(joinCompanyNotifier.notifier)
                  .joinCompany(_codeCompanyCtrl.text)
                  .then((success) {
                if (success) {
                } else {
                  final err = ref.watch(joinCompanyNotifier).error;
                  showSnackbar(context, err!, type: SnackBarType.error);
                }
              });
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }
}
