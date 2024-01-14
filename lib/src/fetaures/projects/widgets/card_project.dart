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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
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
            subtitle: Text(
              project?.description ?? "",
              style: context.theme.textTheme.bodySmall!.copyWith(
                color: context.theme.colorScheme.onPrimary,
              ),
            ),
            trailing: SizedBox(
                width: 100,
                height: 100,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                        value: (project!.percentase! / 100),
                        strokeWidth: 10,
                        backgroundColor: Colors.black.withOpacity(0.5),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.green)),
                    Text(
                      "${project!.percentase}%",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              child: Row(
                children: [
                  Chip(
                    label: Text("Total: ${project?.totalTask}"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Chip(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    label: Text("Undone: ${project?.undone}"),
                  ),
                  const SizedBox(width: 10),
                  Chip(
                    label: Text("Done: ${project?.done}"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
