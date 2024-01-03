part of "../../../../project.dart";

class HeaderWidget extends ConsumerWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final project = ref.watch(detailProjectNotifier).data;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: ListTile(
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
        trailing: IconButton(
          tooltip: "add_task".tr(),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => const DialogAddTaskWidget(),
            );
          },
          icon: Icon(
            Icons.add,
            color: context.theme.colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}
