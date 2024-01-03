part of "../../user.dart";

class ProfileDataWidget extends ConsumerWidget {
  const ProfileDataWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(userNotifier).data;
    final totalCompany = ref.watch(totalMyCompanyNotifier).total;
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Stack(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                alignment: Alignment.bottomRight,
                width: double.infinity,
                height: 150,
                color: context.theme.colorScheme.primary,
                child: LayoutBuilder(builder: (_, constraint) {
                  return SizedBox(
                    width: constraint.maxWidth * 0.55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TotalJoinWidget(
                            total: totalCompany ?? 0, title: "Join Company"),
                        const TotalJoinWidget(total: 0, title: "Join Project"),
                      ],
                    ),
                  );
                }),
              ),
              Positioned(
                  bottom: 0,
                  left: 10,
                  child: data?.image != null
                      ? CircleAvatarNetwork(data?.image, size: 170)
                      : ProfileWithName(data?.name ?? "  ", size: 170)),
            ],
          ),
        ),
        ListTile(
          title: Text(
            data?.name ?? "",
            style: context.theme.textTheme.headlineMedium!,
          ),
        ),
        ListTile(
          visualDensity: const VisualDensity(vertical: -4),
          leading: const Icon(Icons.email_outlined),
          title: Text(
            data?.email ?? "",
            style: context.theme.textTheme.bodyLarge!,
          ),
        ),
        ListTile(
          visualDensity: const VisualDensity(vertical: -4),
          leading: const Icon(Icons.location_on_outlined),
          title: Text(
            (data?.address ?? Address()).formattedAddress,
            style: context.theme.textTheme.bodyLarge!,
          ),
        ),
        const Divider(),
        const SizedBox(height: 20),
      ],
    );
  }
}
