part of "../project.dart";

class CardProject extends StatelessWidget {
  final Project? project;
  const CardProject(this.project, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.theme.colorScheme.primary.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: context.theme.colorScheme.primary,
          width: 2,
        ),
      ),
      child: ListTile(
        onTap: () =>
            nextPage(context, "/project/detail", argument: project!.id),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        title: Text(
          project?.name ?? "",
          style: context.theme.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: context.theme.colorScheme.onPrimary),
        ),
        subtitle: Text(project?.description ?? "",
            style: context.theme.textTheme.bodySmall!.copyWith(
              color: context.theme.colorScheme.onPrimary,
            )),
      ),
    );
  }
}
