part of "../../employee.dart";

class EmployeeItemWidget extends StatelessWidget {
  final Employee data;
  const EmployeeItemWidget(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        trailing: Chip(
            backgroundColor: data.type?.name == "owner"
                ? context.theme.colorScheme.tertiary.withOpacity(0.5)
                : null,
            label: Text(data.type?.name ?? "")),
      ),
    );
  }
}
