part of "../../user.dart";

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          onPressed: () => nextPage(context, "/profile/form"),
          icon: const Icon(Icons.edit),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
