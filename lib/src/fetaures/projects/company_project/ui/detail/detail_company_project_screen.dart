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
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            if (detailCompany.data?.image != null)
              SizedBox(
                height: 70,
                width: 70,
                child: CachedNetworkImage(
                  imageUrl:
                      "${ConstantUrl.BASEIMGURL}/${detailCompany.data!.image!}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const LoadingWidget(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ListTile(
              title: Text(
                detailCompany.data?.name ?? "",
                textAlign: TextAlign.center,
                style: context.theme.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                detailCompany.data?.description ?? "",
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("20 Employee"),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward),
              ),
            ),
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.assignment),
                  title: const Text("10 Project"),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Chip(label: Text("TODO : 12")),
                    Chip(label: Text("DOING : 5")),
                    Chip(label: Text("DONE : 10")),
                  ],
                )
              ],
            ),
            ListTile(
              title: Text("list_project".tr()),
            ),
            SizedBox(
              height: size.height * 0.6,
              child: ListView.separated(
                itemBuilder: (_, i) => Card(
                  elevation: 2,
                  color: context.theme.colorScheme.primary.withOpacity(0.5),
                  child: ListTile(
                    title: Text("Project ${i + 1}"),
                    subtitle: Text("Description Project ${i + 1}"),
                  ),
                ),
                separatorBuilder: (_, i) => const Divider(),
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
