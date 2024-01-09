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
    ref.watch(logBookNotifier.notifier).refresh(widget.companyId);
  }

  @override
  void initState() {
    Future.microtask(() async {
      ref.invalidate(indexScreenProvider);
      await _getData();
    });
    super.initState();
  }

  void _changeIndex(int index) {
    ref.read(indexScreenProvider.notifier).state = index;
  }

  @override
  Widget build(BuildContext context) {
    final indexScreen = ref.watch(indexScreenProvider);
    return Scaffold(
      // extendBodyBehindAppBar: true,
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
      body: Padding(
        padding: EdgeInsets.all(context.isDesktop ? 25.0 : 10.0),
        child: Row(
          children: [
            if (context.isDesktop)
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: indexScreen == 0
                            ? BorderSide(
                                color: context.theme.colorScheme.primary,
                                width: 2,
                              )
                            : BorderSide.none,
                      ),
                      child: ListTile(
                        onTap: () => _changeIndex(0),
                        leading: const Icon(Icons.home),
                        title: Text("home".tr()),
                      ),
                    ),
                    Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: indexScreen == 1
                            ? BorderSide(
                                color: context.theme.colorScheme.primary,
                                width: 2,
                              )
                            : BorderSide.none,
                      ),
                      child: ListTile(
                        onTap: () => _changeIndex(1),
                        leading: const Icon(Icons.assignment),
                        title: Text("task".tr()),
                      ),
                    ),
                    Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: indexScreen == 2
                            ? BorderSide(
                                color: context.theme.colorScheme.primary,
                                width: 2,
                              )
                            : BorderSide.none,
                      ),
                      child: ListTile(
                        onTap: () => _changeIndex(2),
                        leading: const Icon(Icons.book),
                        title: Text("logbook".tr()),
                      ),
                    ),
                    Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: indexScreen == 3
                            ? BorderSide(
                                color: context.theme.colorScheme.primary,
                                width: 2,
                              )
                            : BorderSide.none,
                      ),
                      child: ListTile(
                        onTap: () => _changeIndex(3),
                        leading: const Icon(Icons.more_horiz),
                        title: Text("more".tr()),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            if (context.isDesktop) const SizedBox(width: 50),
            Expanded(
              flex: context.isDesktop ? 3 : 1,
              child: IndexedStack(
                index: indexScreen,
                children: [
                  DashboardHomeWidget(widget.companyId),
                  const DashboardTaskWidget(),
                  const LogBookScreen(),
                  const DashboardMoreWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: context.isMobile
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: context.theme.colorScheme.primary,
              selectedItemColor: context.theme.colorScheme.onSurface,
              showUnselectedLabels: true,
              currentIndex: indexScreen,
              onTap: (index) =>
                  ref.read(indexScreenProvider.notifier).state = index,
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
                  icon: const Icon(Icons.book),
                  label: "logbook".tr(),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.more_horiz),
                  label: "more".tr(),
                ),
              ],
            )
          : null,
    );
  }
}
