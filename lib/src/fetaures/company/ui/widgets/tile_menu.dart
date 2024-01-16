part of "../../company.dart";

class TileMenuWidget extends ConsumerWidget {
  final bool isActive;
  final void Function() onTap;
  final String name;
  final IconData icon;
  const TileMenuWidget({
    super.key,
    required this.isActive,
    required this.onTap,
    required this.name,
    required this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: isActive
            ? BorderSide(
                color: context.theme.colorScheme.primary,
                width: 2,
              )
            : BorderSide.none,
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon),
        title: Text(name),
      ),
    );
  }
}
