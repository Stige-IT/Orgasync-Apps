part of "../../../project.dart";

class DetailCompanyProjectScreen extends ConsumerStatefulWidget {
  final String companyProjectId;

  const DetailCompanyProjectScreen(this.companyProjectId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailCompanyProjectScreenState();
}

class _DetailCompanyProjectScreenState
    extends ConsumerState<DetailCompanyProjectScreen> {
  void _getData() {
    ref
        .read(detailCompanyProjectNotifier.notifier)
        .get(widget.companyProjectId);
    ref
        .read(memberCompanyProjectNotifier.notifier)
        .refresh(widget.companyProjectId);
    ref.watch(priorityNotifier.notifier).getPriorities();
    ref.read(projectsNotifier.notifier).get(widget.companyProjectId);
  }

  @override
  void initState() {
    Future.microtask(() => _getData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final roleUser = ref.watch(roleInCompanyNotifier).data;
    final detailCompany = ref.watch(detailCompanyProjectNotifier);
    final projects = ref.watch(projectsNotifier).data;
    Size size = MediaQuery.of(context).size;
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          elevation: 0,
          centerTitle: true,
          actions: [
            if (roleUser == Role.owner)
              IconButton(
                onPressed: () {
                  nextPage(
                    context,
                    "/company/project/form",
                    argument: detailCompany.data?.companyProject,
                  );
                },
                icon: const Icon(Icons.edit),
              ),
            const SizedBox(width: 20),
          ],
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints(minWidth: 0, maxWidth: 1024),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  if (detailCompany.data?.companyProject?.image != null)
                    SizedBox(
                      height: context.isMobile ? 70 : 140,
                      width: context.isMobile ? 70 : 140,
                      child: CachedNetworkImage(
                        imageUrl:
                            "${ConstantUrl.BASEIMGURL}/${detailCompany.data!.companyProject?.image!}",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const LoadingWidget(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ListTile(
                    title: Text(
                      detailCompany.data?.companyProject?.name ?? "",
                      textAlign: TextAlign.center,
                      style: context.theme.textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      detailCompany.data?.companyProject?.description ?? "",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ListTile(
                    onTap: () => nextPage(context, "/company/project/employee"),
                    leading: const Icon(Icons.people),
                    title: Text(
                        "${detailCompany.data?.totalEmployee} ${'employee'.tr()}"),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                  Column(
                    children: [
                      ListTile(
                        onTap: () => nextPage(context, "/project"),
                        leading: const Icon(Icons.assignment),
                        title: Text(
                            "${detailCompany.data?.totalProject} ${'project'.tr()}"),
                        trailing: const Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    title: Text("list_project".tr()),
                  ),
                  const Divider(),
                  if (projects?.isEmpty ?? true)
                    const Padding(
                      padding: EdgeInsets.only(top: 40.0),
                      child: EmptyWidget(),
                    )
                  else
                    SizedBox(
                      height: size.height * 0.6,
                      child: ListView.separated(
                        itemBuilder: (_, i) {
                          final project = (projects ?? [])[i];
                          return CardProject(project);
                        },
                        separatorBuilder: (_, i) => const Divider(),
                        itemCount: (projects ?? []).length,
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
