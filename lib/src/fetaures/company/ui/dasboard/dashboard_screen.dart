part of "../../company.dart";

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: ListView(
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
                const Positioned(
                  left: 50,
                  right: 50,
                  bottom: 0,
                  child: CircleAvatar(radius: 60),
                )
              ],
            ),
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            title: Text(
              "Nama company",
              textAlign: TextAlign.center,
              style: context.theme.textTheme.headlineMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            subtitle: const Text(
              "IT Company",
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: double.infinity,
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus eget cursus sapien, non laoreet lacus. Duis vitae ligula consectetur, commodo justo nec, mollis augue. In tristique auctor leo in condimentum.",
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

          SizedBox(height: 20),
          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.location_city),
                visualDensity: const VisualDensity(vertical: -4),
                title: Text("Structure organization"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 15),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.people),
                visualDensity: const VisualDensity(vertical: -4),
                title: Text("Employee"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 15),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.assignment),
                visualDensity: const VisualDensity(vertical: -4),
                title: Text("Project"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 15),
              ),
            ],
          )
        ],
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
