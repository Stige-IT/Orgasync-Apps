part of "../../user.dart";

class SettingWidget extends ConsumerStatefulWidget {
  const SettingWidget({super.key});

  @override
  ConsumerState createState() => _SettingWidgetState();
}

class _SettingWidgetState extends ConsumerState<SettingWidget> {
  @override
  Widget build(BuildContext context) {
    Locale locale = context.locale;
    final theme = ref.watch(themeProvider);
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.settings),
          title: Text("Settings", style: context.theme.textTheme.bodyLarge!),
        ),
        ListTile(
          onTap: () {
            if (locale == const Locale("en", "US")) {
              context.setLocale(const Locale("id"));
            } else {
              context.setLocale(const Locale("en", "US"));
            }
          },
          title: Text("language".tr()),
          trailing: Text(locale.formattedLocale),
        ),
        ListTile(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text("theme".tr()),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      onTap: () => _changeTheme(ThemeMode.light),
                      shape: theme == ThemeMode.light ? _active() : null,
                      title: const Text("Light"),
                      trailing: const Icon(Icons.lightbulb_outline),
                    ),
                    ListTile(
                      onTap: () => _changeTheme(ThemeMode.dark),
                      shape: theme == ThemeMode.dark ? _active() : null,
                      title: const Text("Dark"),
                      trailing: const Icon(Icons.dark_mode_outlined),
                    ),
                  ],
                ),
              ),
            );
          },
          title: Text("theme".tr()),
          trailing:
              theme == ThemeMode.dark ? Text("dark".tr()) : Text("light".tr()),
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

  void _changeTheme(ThemeMode theme) {
    ref.read(themeProvider.notifier).setTheme(theme);
    Navigator.of(context).pop();
  }

  RoundedRectangleBorder _active() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: const BorderSide(color: Colors.grey),
    );
  }
}
