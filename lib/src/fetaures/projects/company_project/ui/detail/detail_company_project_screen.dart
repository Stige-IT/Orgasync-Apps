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
  }

  @override
  void initState() {
    Future.microtask(() => _getData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final detailCompany = ref.watch(detailCompanyProjectNotifier);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                nextPage(
                  context,
                  "/company/project/form",
                  argument: detailCompany.data?.companyProject,
                );
              },
              icon: const Icon(Icons.edit)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            if (detailCompany.data?.companyProject?.image != null)
              SizedBox(
                height: 70,
                width: 70,
                child: CachedNetworkImage(
                  imageUrl:
                      "${ConstantUrl.BASEIMGURL}/${detailCompany.data!.companyProject?.image!}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const LoadingWidget(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
              leading: const Icon(Icons.people),
              title: Text(
                  "${detailCompany.data?.totalEmployee} ${'employee'.tr()}"),
              trailing: IconButton(
                onPressed: () => nextPage(context, "/company/project/employee"),
                icon: const Icon(Icons.arrow_forward),
              ),
            ),
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.assignment),
                  title: Text(
                      "${detailCompany.data?.totalProject} ${'project'.tr()}"),
                  trailing: IconButton(
                    onPressed: () => nextPage(context, "/project"),
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Text("list_project".tr()),
            ),
            const Divider(),
            if (detailCompany.data?.project?.isEmpty ?? true)
              const Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: EmptyWidget(),
              )
            else
              SizedBox(
                height: size.height * 0.6,
                child: ListView.separated(
                  itemBuilder: (_, i) {
                    final project = detailCompany.data?.project?[i];
                    return CardProject(project);
                  },
                  separatorBuilder: (_, i) => const Divider(),
                  itemCount: detailCompany.data?.project?.length ?? 0,
                ),
              )
          ],
        ),
      ),
    );
  }
}
