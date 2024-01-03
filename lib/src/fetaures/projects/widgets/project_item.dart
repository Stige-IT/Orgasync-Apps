part of "../project.dart";

class ProjectItemWidget extends StatelessWidget {
  final CompanyProject data;
  const ProjectItemWidget(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: context.theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Builder(builder: (_) {
              if (data.image != null) {
                return CachedNetworkImage(
                  imageUrl: "${ConstantUrl.BASEIMGURL}/${data.image!}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const LoadingWidget(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                );
              } else {
                return Image.asset('assets/images/app_logo.png',
                    fit: BoxFit.cover);
              }
            }),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: context.isMobile ? size.width * .5 : size.width * .3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  data.description ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.textTheme.bodySmall!.copyWith(
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
          ),
        ],
      ),
    );
  }
}
