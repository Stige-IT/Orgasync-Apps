part of "../../company.dart";

class DashboardScreen extends ConsumerStatefulWidget {
  final String companyId;
  const DashboardScreen(this.companyId, {super.key});

  @override
  ConsumerState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  Future<void> _getData() async {
    await ref.read(roleInCompanyNotifier.notifier).check(widget.companyId);
  }

  @override
  void initState() {
    Future.microtask(() async {
      ref.invalidate(indexScreenProvider);
      await _getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final indexScreen = ref.watch(indexScreenProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.colorScheme.background.withOpacity(0),
        foregroundColor: context.theme.colorScheme.onSurfaceVariant,
        centerTitle: true,
        title: Text(
          "dashboard".tr(),
          style: context.theme.textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: IndexedStack(
        index: indexScreen,
        children: [
          DashboardHomeWidget(widget.companyId),
          const DashboardTaskWidget(),
          const DashboardMoreWidget(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: context.theme.colorScheme.primary,
        selectedItemColor: context.theme.colorScheme.onSurface,
        showUnselectedLabels: true,
        currentIndex: indexScreen,
        onTap: (index) => ref.read(indexScreenProvider.notifier).state = index,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: "home".tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.assignment),
            label: "task".tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: "more".tr(),
          ),
        ],
      ),
    );
  }
}
