part of "../../user.dart";

class SearchUserScreen extends ConsumerStatefulWidget {
  final String companyId;
  const SearchUserScreen(this.companyId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchUserScreenState();
}

class _SearchUserScreenState extends ConsumerState<SearchUserScreen> {
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

  bool _joinedUser(List<Employee> employee, UserData user) {
    return employee.any((e) => e.user?.id == user.id);
  }

  @override
  Widget build(BuildContext context) {
    final candidate = ref.watch(candidateUserNotifier);
    final employee = ref.watch(employeeCompanyNotifier).data;
    final users = ref.watch(searchUserNotifier);
    final addLoading = ref.watch(addEmployeeNotifier).isLoading;
    return Scaffold(
      appBar: AppBar(title: Text("search_user".tr())),
      body: Stack(
        children: [
          Padding(
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
                          ref.read(searchUserNotifier.notifier).search(value);
                        },
                        suffixIcon: _searchCtrl.text.isEmpty
                            ? null
                            : IconButton(
                                onPressed: () {
                                  _searchCtrl.clear();
                                  ref.invalidate(searchUserNotifier);
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
                          backgroundColor: context.theme.colorScheme.tertiary
                              .withOpacity(0.5),
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
                                backgroundColor: context
                                    .theme.colorScheme.tertiary
                                    .withOpacity(0.5),
                                label: Text(e.email ?? ""),
                                deleteIcon: const Icon(Icons.close, size: 20),
                                onDeleted: () {
                                  ref
                                      .read(candidateUserNotifier.notifier)
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
                    final user = users.data![i];
                    return ListTile(
                      leading: Builder(builder: (_) {
                        if (user.image != null) {
                          return CircleAvatarNetwork(user.image, size: 40);
                        } else {
                          return ProfileWithName(user.name ?? "  ", size: 40);
                        }
                      }),
                      title: Text(user.name ?? ""),
                      subtitle: Text(user.email ?? ""),
                      trailing: IconButton(
                        icon: Builder(builder: (_) {
                          if (candidate.contains(user)) {
                            return const Icon(Icons.check);
                          } else if (_joinedUser(employee ?? [], user)) {
                            return Text("joined".tr());
                          }
                          return const Icon(Icons.add);
                        }),
                        onPressed: () {
                          if (candidate.contains(user)) return;
                          if (_joinedUser(employee ?? [], user)) return;
                          ref.read(candidateUserNotifier.notifier).add(user);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (_, i) => const Divider(),
                  itemCount: (users.data ?? []).length,
                )),
              ],
            ),
          ),
          if (addLoading) const DialogLoading(),
        ],
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
            DialogCandidateWidget(),
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
    final candidate = ref.watch(candidateUserNotifier);
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
                    ref
                        .read(addEmployeeNotifier.notifier)
                        .add(widget.companyId, users: candidate)
                        .then((success) {
                      if (success) {
                        Navigator.of(context).pop();
                        showSnackbar(context, "succes".tr(),
                            type: SnackBarType.success);
                      } else {
                        showSnackbar(context, "failed".tr(),
                            type: SnackBarType.error);
                      }
                    });
                  },
                  child: Text("invite".tr()),
                ),
              ],
            ));
  }
}
