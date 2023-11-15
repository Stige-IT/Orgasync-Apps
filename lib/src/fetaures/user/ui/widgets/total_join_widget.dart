part of "../../user.dart";

class TotalJoinWidget extends StatelessWidget {
  final int total;
  final String title;
  const TotalJoinWidget({super.key, required this.total, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
        tileColor: context.theme.colorScheme.primary,
        title: Text(
          "$total",
          textAlign: TextAlign.center,
          style:
          context.theme.textTheme.displayMedium!.copyWith(
            color: context.theme.colorScheme.onPrimary,
          ),
        ),
        subtitle: Text(
          title,
          textAlign: TextAlign.center,
          style: context.theme.textTheme.bodySmall!.copyWith(
            color: context.theme.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
