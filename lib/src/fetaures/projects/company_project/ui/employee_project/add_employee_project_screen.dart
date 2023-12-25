part of "../../../project.dart";

class AddEmployeeProjectScreen extends ConsumerStatefulWidget {
  const AddEmployeeProjectScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddEmployeeProjectScreenState();
}

class _AddEmployeeProjectScreenState
    extends ConsumerState<AddEmployeeProjectScreen> {
  late TextEditingController _searchCtrl;

  @override
  void initState() {
    _searchCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  bool _joinedUser(List<Employee> employee, Employee user) {
    return employee.any((e) => e.user?.id == user.id);
  }

  @override
  Widget build(BuildContext context) {
    final candidate = ref.watch(employeProjectTempProvider);
    final employees = ref.watch(searchEmployeeNotifier);
    final companyId = ref.watch(detailCompanyNotifier).data?.id;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("add_employee_project".tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: FieldInput(
                    prefixIcons: const Icon(Icons.search),
                    hintText: "search_email_user",
                    controllers: _searchCtrl,
                    onChanged: (value) {
                      ref
                          .read(searchEmployeeNotifier.notifier)
                          .search(companyId!, value);
                    },
                    suffixIcon: _searchCtrl.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () {
                              _searchCtrl.clear();
                              ref.invalidate(searchEmployeeNotifier);
                            },
                            icon: const Icon(Icons.close),
                          ),
                  ),
                ),
                const SizedBox(width: 15),
                if (candidate.isNotEmpty)
                  ElevatedButton(
                    onPressed: _dialogInviteUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          context.theme.colorScheme.tertiary.withOpacity(0.5),
                      foregroundColor: context.theme.colorScheme.onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("invite".tr()),
                  ),
              ],
            ),
            // list wrap of candidate user for add to company
            if (candidate.length >= 5)
              ListTile(
                leading: Icon(
                  Icons.people,
                  color: context.theme.colorScheme.tertiary,
                ),
                title: Text("${candidate.length} ${"candidate".tr()}"),
                trailing: TextButton(
                  onPressed: _dialogCandidate,
                  child: Text("view_all".tr()),
                ),
              )
            else
              Align(
                alignment: Alignment.topLeft,
                child: Wrap(
                  spacing: 5,
                  children: candidate
                      .map((e) => Chip(
                            backgroundColor: context.theme.colorScheme.tertiary
                                .withOpacity(0.5),
                            label: Text(e.user?.email ?? ""),
                            deleteIcon: const Icon(Icons.close, size: 20),
                            onDeleted: () {
                              ref
                                  .read(employeProjectTempProvider.notifier)
                                  .remove(e);
                            },
                          ))
                      .toList(),
                ),
              ),
            const SizedBox(height: 10),
            Expanded(
                child: ListView.separated(
              itemBuilder: (_, i) {
                final employee = employees.data![i].user!;
                return ListTile(
                  leading: Builder(builder: (_) {
                    if (employee.image != null) {
                      return CircleAvatarNetwork(employee.image, size: 40);
                    } else {
                      return ProfileWithName(employee.name ?? "  ", size: 40);
                    }
                  }),
                  title: Text(employee.name ?? ""),
                  subtitle: Text(employee.email ?? ""),
                  trailing: IconButton(
                    icon: Builder(builder: (_) {
                      if (candidate.contains(employees.data![i])) {
                        return const Icon(Icons.check);
                      } else if (_joinedUser(
                          employees.data!, employees.data![i])) {
                        return Text("joined".tr());
                      }
                      return const Icon(Icons.add);
                    }),
                    onPressed: () {
                      if (candidate.contains(employees.data![i])) return;
                      if (_joinedUser(employees.data!, employees.data![i])) {
                        return;
                      }
                      ref
                          .read(employeProjectTempProvider.notifier)
                          .add(employees.data![i]);
                    },
                  ),
                );
              },
              separatorBuilder: (_, i) => const Divider(),
              itemCount: (employees.data ?? []).length,
            )),
          ],
        ),
      ),
    );
  }

  _dialogCandidate() {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        insetPadding: const EdgeInsets.all(10.0),
        scrollable: true,
        title: SizedBox(
          width: size.width,
          child: Text("candidate".tr()),
        ),
        content: const Column(
          children: [
            DialogCandidateEmployeeWidget(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text("cancel".tr()),
          ),
        ],
      ),
    );
  }

  _dialogInviteUser() {
    final candidate = ref.watch(employeProjectTempProvider);
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("invite".tr()),
              content: ListTile(
                leading: Icon(Icons.people,
                    color: context.theme.colorScheme.tertiary),
                title: Text(" ${candidate.length} ${"candidate".tr()}"),
              ),
              actions: [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: Text("cancel".tr()),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    final idCompanyProject = ref
                        .watch(detailCompanyProjectNotifier)
                        .data!
                        .companyProject!
                        .id;
                    final employees = ref.watch(employeProjectTempProvider);
                    final idEmployees = employees.map((e) => e.id!).toList();
                    ref
                        .read(addMemberToCompanyProjectNotifier.notifier)
                        .add(idCompanyProject!, idEmployees)
                        .then((success) {
                      if (success) {
                        Navigator.of(context).pop();
                        ref.read(employeProjectTempProvider.notifier).clear();
                        showSnackbar(context, "invite_success".tr());
                      } else {
                        final err =
                            ref.watch(addMemberToCompanyProjectNotifier).error;
                        showSnackbar(context, err!, type: SnackBarType.error);
                      }
                    });
                  },
                  child: Text("invite".tr()),
                ),
              ],
            ));
  }
}
