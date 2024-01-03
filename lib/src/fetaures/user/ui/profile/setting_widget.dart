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
        // check update version
        ListTile(
          onTap: _checkForUpdate,
          title: Text("check_update_version".tr()),
          trailing: const Icon(Icons.update_outlined),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            ref.read(storageProvider).deleteAll();
            nextPageRemoveAll(context, "/login");
          },
          title: const Text("Logout"),
          trailing: const Icon(Icons.logout, color: Colors.red),
        ),
        const SizedBox(height: 20),
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

  void _checkForUpdate() async {
    final isUpdateAvailable =
        await shoreBirdCodePush.isNewPatchAvailableForDownload();
    if (isUpdateAvailable) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("already_update".tr()),
          content: Text("update_available_please_download".tr()),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text("cancel".tr()),
            ),
            ElevatedButton(
              onPressed: _downloadUpdate,
              child: Text("download".tr()),
            ),
          ],
        ),
      );
    } else {
      if (!mounted) return;
      showSnackbar(context, "Tidak ada update tersedia");
    }
  }

  Future<void> _downloadUpdate() async {
    Navigator.of(context).pop();
    _showDownloadingBanner();

    await Future.wait([
      shoreBirdCodePush.downloadUpdateIfAvailable(),
      Future<void>.delayed(const Duration(milliseconds: 250)),
    ]);

    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    _showRestartBanner();
  }

  _showRestartBanner() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => const AlertDialog(
        title: Text("Update berhasil di download"),
        content: Text("Silahkan restart aplikasi"),
        actions: [
          ElevatedButton(
            onPressed: Restart.restartApp,
            child: Text("Restart"),
          ),
        ],
      ),
    );
  }

  void _showDownloadingBanner() {
    ScaffoldMessenger.of(context).showMaterialBanner(
      const MaterialBanner(
        content: Text('Downloading...'),
        actions: [
          SizedBox(
            height: 14,
            width: 14,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ],
      ),
    );
  }
}
