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
                    TileMenuWidget(
                      isActive: indexScreen == 0,
                      onTap: () {
                        _changeIndex(0);
                        ref
                            .read(detailCompanyNotifier.notifier)
                            .get(widget.companyId);
                      },
                      name: "Home",
                      icon: Icons.home,
                    ),
                    TileMenuWidget(
                      isActive: indexScreen == 1,
                      onTap: () => _changeIndex(1),
                      name: "Task",
                      icon: Icons.assignment,
                    ),
                    TileMenuWidget(
                      isActive: indexScreen == 2,
                      onTap: () {
                        _changeIndex(2);
                        ref
                            .read(logBookNotifier.notifier)
                            .get(widget.companyId);
                      },
                      name: "Logbook",
                      icon: Icons.book,
                    ),
                    TileMenuWidget(
                      isActive: indexScreen == 3,
                      onTap: () => _changeIndex(3),
                      name: "More",
                      icon: Icons.more_horiz,
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
                  DashboardTaskWidget(widget.companyId),
                  LogBookScreen(widget.companyId),
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
