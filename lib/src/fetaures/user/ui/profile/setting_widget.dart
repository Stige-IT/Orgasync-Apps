part of "../../user.dart";

class SettingWidget extends ConsumerWidget {
  const SettingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
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
        ListTile(
          onTap: () {
            ref.read(storageProvider).delete("token");
            nextPageRemoveAll(context, "/login");
          },
          title: const Text("Logout"),
          trailing: const Icon(Icons.logout),
        ),
      ],
    );
  }
}
