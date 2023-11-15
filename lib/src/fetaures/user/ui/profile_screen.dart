part of "../user.dart";

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.colorScheme.primary,
        foregroundColor: context.theme.colorScheme.onPrimary,
        title: Text(
          "profile".tr(),
          style: context.theme.textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.w600,
            color: context.theme.colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal :5, vertical: 10),
                  alignment: Alignment.bottomRight,
                  width: double.infinity,
                  height: 150,
                  color: context.theme.colorScheme.primary,
                  child: LayoutBuilder(
                    builder: (_, constraint) {
                      return SizedBox(
                        width: constraint.maxWidth * 0.55,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TotalJoinWidget(total: 5, title: "Join Company"),
                            TotalJoinWidget(total: 10, title: "Join Project"),
                          ],
                        ),
                      );
                    }
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 20,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: context.theme.colorScheme.background,
                    backgroundImage:
                        const AssetImage("assets/images/profile.png"),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            title: Text(
              "Zamzam Nurahman",
              style: context.theme.textTheme.headlineMedium!,
            ),
            subtitle: Text(
              "Software Engineer",
              style: context.theme.textTheme.bodyLarge,
            ),
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            leading: const Icon(Icons.email_outlined),
            title: Text(
              "kazamnn1912@gmail.com",
              style: context.theme.textTheme.bodyLarge!,
            ),
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            leading: const Icon(Icons.location_on_outlined),
            title: Text(
              "Garut, Indonesia",
              style: context.theme.textTheme.bodyLarge!,
            ),
          ),
          const Divider(),
          const SizedBox(height: 20),
          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text("Settings", style: context.theme.textTheme.bodyLarge!),
              ),
              const ListTile(
                title: Text("Language"),
                trailing: Text("English"),
              ),
              const ListTile(
                title: Text("Theme"),
                trailing: Text("Dark"),
              ),
              const ListTile(
                title: Text("Logout"),
                trailing: Icon(Icons.logout),
              ),
            ],
          )
        ],
      ),
    );
  }
}
