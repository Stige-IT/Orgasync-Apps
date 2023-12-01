part of "../../project.dart";

class CompanyProjectScreen extends ConsumerStatefulWidget {
  final String companyId;
  const CompanyProjectScreen(this.companyId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompanyProjectScreenState();
}

class _CompanyProjectScreenState extends ConsumerState<CompanyProjectScreen> {
  void _getData() {
    ref.read(companyProjectNotifier.notifier).refresh(widget.companyId);
  }

  @override
  void initState() {
    Future.microtask(() => _getData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.colorScheme.background,
        foregroundColor: context.theme.colorScheme.onSurfaceVariant,
        centerTitle: true,
        title: Text(
          "project".tr(),
          style: context.theme.textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2), () => _getData());
        },
        child: Builder(builder: (_) {
          final project = ref.watch(companyProjectNotifier);
          if (project.isLoading) {
            return const Center(child: LoadingWidget());
          } else if (project.error != null) {
            return ErrorButtonWidget(project.error!, () => _getData());
          } else if (project.data == null) {
            return const EmptyWidget();
          } else {
            return ListView.builder(
              itemCount: project.data!.length,
              itemBuilder: (_, index) {
                final data = project.data![index];
                return ProjectItemWidget(data);
              },
            );
          }
        }),
      ),
    );
  }
}

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
            style: context.theme.textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w400,
              color: context.theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.createdAt!.dateFormat(),
            style: context.theme.textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w400,
              color: context.theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
