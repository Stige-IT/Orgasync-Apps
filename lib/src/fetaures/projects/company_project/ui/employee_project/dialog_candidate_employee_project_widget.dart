part of "../../../project.dart";

class DialogCandidateEmployeeWidget extends ConsumerWidget {
  const DialogCandidateEmployeeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final candidate = ref.watch(employeProjectTempProvider);
    return Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.people,
            color: context.theme.colorScheme.tertiary,
          ),
          title: Text("${candidate.length} ${"candidate".tr()}"),
        ),
        SingleChildScrollView(
          child: Column(
              children: candidate
                  .map((employee) => ListTile(
                        leading: Builder(builder: (_) {
                          if (employee.user!.image != null) {
                            return CircleAvatarNetwork(employee.user!.image,
                                size: 40);
                          } else {
                            return ProfileWithName(employee.user!.name ?? "  ",
                                size: 40);
                          }
                        }),
                        title: Text(employee.user!.name ?? ""),
                        subtitle: Text(employee.user!.email ?? ""),
                        trailing: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            ref
                                .read(employeProjectTempProvider.notifier)
                                .remove(employee);
                          },
                        ),
                      ))
                  .toList()),
        )
      ],
    );
  }
}
