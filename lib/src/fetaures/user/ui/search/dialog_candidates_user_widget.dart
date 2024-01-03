part of "../../user.dart";

class DialogCandidateWidget extends ConsumerWidget {
  const DialogCandidateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final candidate = ref.watch(candidateUserNotifier);
    return Column(
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
                  .map((user) => ListTile(
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
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            ref
                                .read(candidateUserNotifier.notifier)
                                .remove(user);
                          },
                        ),
                      ))
                  .toList()),
        )
      ],
    );
  }
}
