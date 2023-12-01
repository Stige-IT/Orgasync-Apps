part of "../project.dart";

class ProjectItemWidget extends StatelessWidget {
  final CompanyProject data;
  const ProjectItemWidget(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: context.theme.colorScheme.onBackground.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.name ?? "",
            style: context.theme.textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w600,
              color: context.theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.description ?? "",
            style: context.theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              color: context.theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.createdAt!.dateFormat(),
            style: context.theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              color: context.theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
