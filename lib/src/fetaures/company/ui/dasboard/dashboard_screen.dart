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
    ref.read(totalCompanyProjectNotifier.notifier).get(widget.companyId);
    ref.read(employeeCompanyNotifier.notifier).getEmployee(widget.companyId);
  }

  @override
  void initState() {
    Future.microtask(() => _getData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final company = ref.watch(detailCompanyNotifier);
    final totalProject = ref.watch(totalCompanyProjectNotifier).total;
    return Scaffold(
      extendBodyBehindAppBar: true,
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
          final employee = ref.watch(employeeCompanyNotifier);
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
                      if (company.data?.cover != null)
                        Container(
                          height: 130,
                          width: double.infinity,
                          color: context.theme.colorScheme.primary,
                        )
                      else
                        SizedBox(
                          height: 130,
                          width: double.infinity,
                          child: Image.asset(
                            "assets/images/three_human.png",
                            fit: BoxFit.cover,
                          ),
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
                            for (int i = 0; i < 4; i++)
                              if (i < employee.data!.length)
                                if (employee.data?[i].user?.image != null)
                                  CircleAvatarNetwork(
                                      employee.data?[i].user?.image,
                                      size: 40)
                                else
                                  ProfileWithName(employee.data?[i].user?.name,
                                      size: 40),
                            if (employee.total > 4)
                              Container(
                                alignment: Alignment.center,
                                width: 25,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.orange,
                                ),
                                child: Text('+${employee.total}'),
                              )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        onTap: () => nextPage(context, "/company/project",
                            argument: widget.companyId),
                        title: const Text("Total Project"),
                        subtitle: Text(
                          "$totalProject",
                          style: context.theme.textTheme.headlineLarge,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    const ListTile(
                      leading: Icon(Icons.location_city),
                      visualDensity: VisualDensity(vertical: -4),
                      title: Text("Structure organization"),
                      trailing: Icon(Icons.arrow_forward_ios, size: 15),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.people),
                      visualDensity: VisualDensity(vertical: -4),
                      title: Text("Employee"),
                      trailing: Icon(Icons.arrow_forward_ios, size: 15),
                    ),
                    const Divider(),
                    ListTile(
                      onTap: () => nextPage(context, "/company/project",
                          argument: widget.companyId),
                      leading: const Icon(Icons.assignment),
                      visualDensity: const VisualDensity(vertical: -4),
                      title: const Text("Project"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 15),
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
        unselectedItemColor: context.theme.colorScheme.primary,
        selectedItemColor: context.theme.colorScheme.onSurface,
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
