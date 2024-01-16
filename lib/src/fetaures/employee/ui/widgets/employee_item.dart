part of "../../employee.dart";

class EmployeeItemWidget extends ConsumerWidget {
  final String companyId;
  final Employee data;

  const EmployeeItemWidget(this.data, this.companyId, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(roleInCompanyNotifier).data;
    final typeEmployee = ref.watch(typeEmployeeNotifier).data;
    final user = ref.watch(userNotifier).data;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 20,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        border: user?.id == data.user?.id
            ? Border.all(
                color: context.theme.colorScheme.onBackground,
              )
            : null,
      ),
      child: ListTile(
        title: Text(
          data.user?.name ?? "",
          style: context.theme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          data.user?.email ?? "",
          style: context.theme.textTheme.bodySmall,
        ),
        leading: Builder(
          builder: (_) {
            if (data.user?.image == null) {
              return ProfileWithName(data.user?.name ?? "  ", size: 50);
            } else {
              return CircleAvatarNetwork(data.user?.image, size: 50);
            }
          },
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PopupMenuButton(
              enabled: role == Role.owner,
              onSelected: (newType) {
                ref
                    .read(updateTypeEmployeeNotifier.notifier)
                    .update(companyId, data.id!, idTypeEmployee: newType);
              },
              constraints: const BoxConstraints(
                minWidth: 20,
                maxWidth: double.infinity,
                minHeight: 20,
                maxHeight: 200,
              ),
              itemBuilder: (_) => (typeEmployee ?? [])
                  .map((type) => PopupMenuItem(
                        value: type.id,
                        child: Text(
                          type.name ?? "",
                          style: TextStyle(
                            fontWeight: type.name == data.type?.name
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ))
                  .toList(),
              child: Chip(
                  backgroundColor: data.type?.name == "owner"
                      ? context.theme.colorScheme.tertiary.withOpacity(0.5)
                      : null,
                  label: Text(data.type?.name ?? "")),
            ),
            if (role == Role.owner)
              PopupMenuButton(
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: "delete",
                    child: Text("delete".tr()),
                  )
                ],
                onSelected: (value) {
                  if (value == "delete") {
                    ref
                        .read(deleteEmployeeNotifier.notifier)
                        .delete(data.id!, companyId);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
