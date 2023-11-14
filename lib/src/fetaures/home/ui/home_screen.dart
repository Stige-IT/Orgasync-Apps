part of "../home.dart";

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    Future.microtask(() => ref.read(roleNotifier.notifier).getRole());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading: Image.asset("assets/images/app_logo.png"),
        title: Text("app_name".tr(),
            style: Theme.of(context).textTheme.displaySmall),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     ref.read(storageProvider).delete("token");
          //     nextPageRemoveAll(context, "/login");
          //   },
          //   icon: const Icon(Icons.logout),
          // ),
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
      body: Scrollbar(
        trackVisibility: true,
        thumbVisibility: true,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 30),
          itemBuilder: (_, i) => const CardCompany(),
          itemCount: 2,
        ),
      ),
    );
  }
}
