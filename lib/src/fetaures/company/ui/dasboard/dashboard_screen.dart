part of "../../company.dart";

class DashboardScreen extends ConsumerStatefulWidget {
  final String companyId;
  const DashboardScreen(this.companyId, {super.key});

  @override
  ConsumerState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  void _getData() {
    ref.read(detailCompanyNotifier.notifier).get(widget.companyId);
  }

  @override
  void initState() {
    Future.microtask(() => _getData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final company = ref.watch(detailCompanyNotifier);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.colorScheme.primary,
        foregroundColor: context.theme.colorScheme.onPrimary,
        centerTitle: true,
        title: Text(
          "dashboard".tr(),
          style: context.theme.textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.w600,
            color: context.theme.colorScheme.onPrimary,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2), () => _getData());
        },
        child: Builder(builder: (_) {
          if (company.isLoading) {
            return const Center(child: LoadingWidget());
          } else if (company.error != null) {
            return ErrorButtonWidget(company.error!, () => _getData());
          } else if (company.data == null) {
            return const EmptyWidget();
          } else {
            return ListView(
              children: [
                SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        height: 130,
                        width: double.infinity,
                        color: context.theme.colorScheme.primary,
                      ),
                      Positioned(
                        left: 50,
                        right: 50,
                        bottom: 0,
                        child: company.data?.logo == null
                            ? ProfileWithName(company.data?.name, size: 140)
                            : CircleAvatarNetwork(company.data?.logo,
                                size: 140),
                      )
                    ],
                  ),
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  title: Text(
                    company.data?.name ?? "",
                    textAlign: TextAlign.center,
                    style: context.theme.textTheme.headlineMedium!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    company.data?.typeCompany?.name ?? "-",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.infinity,
                  child: Text(
                    company.data?.description ?? "",
                    textAlign: TextAlign.justify,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text("Total Employee"),
                        subtitle: StackedWidgets(
                          size: 40,
                          xShift: 10,
                          items: [
                            Container(
                              height: 25,
                              decoration: const BoxDecoration(
                                border: Border.fromBorderSide(
                                  BorderSide(color: Colors.white, width: 2),
                                ),
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                            ),
                            Container(
                              height: 25,
                              decoration: const BoxDecoration(
                                border: Border.fromBorderSide(
                                  BorderSide(color: Colors.white, width: 2),
                                ),
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                            ),
                            const CircleAvatar(),
                            Container(
                              alignment: Alignment.center,
                              width: 25,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.orange,
                              ),
                              child: const Text('+22'),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text("Total Project"),
                        subtitle: Text(
                          "50",
                          style: context.theme.textTheme.headlineLarge,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.location_city),
                      visualDensity: VisualDensity(vertical: -4),
                      title: Text("Structure organization"),
                      trailing: Icon(Icons.arrow_forward_ios, size: 15),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.people),
                      visualDensity: VisualDensity(vertical: -4),
                      title: Text("Employee"),
                      trailing: Icon(Icons.arrow_forward_ios, size: 15),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.assignment),
                      visualDensity: VisualDensity(vertical: -4),
                      title: Text("Project"),
                      trailing: Icon(Icons.arrow_forward_ios, size: 15),
                    ),
                  ],
                )
              ],
            );
          }
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: context.theme.colorScheme.onSurfaceVariant,
        selectedItemColor: context.theme.colorScheme.primary,
        showUnselectedLabels: true,
        currentIndex: 0,
        onTap: (index) {},
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
            label: "Me".tr(),
          ),
        ],
      ),
    );
  }
}
