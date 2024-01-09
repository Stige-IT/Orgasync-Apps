part of "../../user.dart";

class FormProfileScreen extends ConsumerStatefulWidget {
  const FormProfileScreen({super.key});

  @override
  ConsumerState createState() => _FormProfileScreenState();
}

class _FormProfileScreenState extends ConsumerState<FormProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text("profile".tr()),
        bottom: TabBar(
          tabAlignment: TabAlignment.center,
          isScrollable: true,
          controller: tabController,
          tabs: [
            Tab(text: "user_data".tr()),
            // Tab(text: "address".tr()),
            Tab(text: "change_password".tr()),
          ],
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(minWidth: 0, maxWidth: 720),
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1), () {
                ref.read(userNotifier.notifier).get();
              });
            },
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: const [
                FormUserdataWidget(),
                // FormUserAddressWidget(),
                FormChangePasswordWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
