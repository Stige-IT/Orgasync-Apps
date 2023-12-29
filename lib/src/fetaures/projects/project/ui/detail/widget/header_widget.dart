part of "../../../../project.dart";

class HeaderWidget extends ConsumerWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final project = ref.watch(detailProjectNotifier).data;
    return ListTile(
      title: Text(
        project?.name ?? "",
        textAlign: TextAlign.center,
        style: context.theme.textTheme.headlineSmall!.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        project?.description ?? "",
        textAlign: TextAlign.center,
        style: context.theme.textTheme.bodySmall!.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(
          Icons.add,
          color: context.theme.colorScheme.onBackground,
        ),
        label: Text(
          "add_task".tr(),
          style: context.theme.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w600,
            color: context.theme.colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}
