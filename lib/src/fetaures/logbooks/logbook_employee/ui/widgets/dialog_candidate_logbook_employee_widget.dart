part of "../../logbook_employee.dart";

class DialogCandidateLogBookEmployeeWidget extends ConsumerWidget {
  const DialogCandidateLogBookEmployeeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final candidate = ref.watch(logBookEmployeeTempProvider);
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: context.theme.colorScheme.primary,
              width: 2,
            ),
          ),
          constraints: const BoxConstraints(minWidth: 0, maxWidth: 1024),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                              leading: AvatarProfile(
                                  image: employee.user?.image,
                                  name: employee.user?.name),
                              title: Text(employee.user!.name ?? ""),
                              subtitle: Text(employee.user!.email ?? ""),
                              trailing: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  ref
                                      .read(
                                          logBookEmployeeTempProvider.notifier)
                                      .remove(employee);
                                },
                              ),
                            ))
                        .toList()),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 100,
                  child: FilledButton(
                    onPressed: Navigator.of(context).pop,
                    child: Text("close".tr()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
