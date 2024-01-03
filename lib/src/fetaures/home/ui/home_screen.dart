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
    ref.read(userNotifier.notifier).get();
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

  void _handleRefresh() {
    if (!kIsWeb) {
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        ref.read(companyNotifier.notifier).refresh();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userNotifier).data;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: context.height * 0.1,
        backgroundColor: Colors.transparent,
        // leading: Image.asset("assets/images/app_logo.png"),
        title: InkWell(
          onTap: _handleRefresh,
          child: Text(
            "app_name".tr(),
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     ref.read(storageProvider).delete("token");
          //     nextPageRemoveAll(context, "/login");
          //   },
          //   icon: const Icon(Icons.logout),
          // ),
          // IconButton(
          //     onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          InkWell(
            onTap: () => nextPage(context, "/profile"),
            child: user == null || user.image == null
                ? ProfileWithName(user?.name)
                : CircleAvatarNetwork(user.image, size: 50),
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
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        spacing: 7,
        spaceBetweenChildren: 10,
        childPadding: const EdgeInsets.all(5),
        buttonSize: const Size(70, 70),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: "create_new_company".tr(),
            onTap: () => nextPage(context, "/company/create"),
          ),
          SpeedDialChild(
            child: const Icon(Icons.group_add),
            label: "join_company".tr(),
            onTap: _handleJoinCompany,
          ),
        ],
      ),
    );
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
