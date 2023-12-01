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
          } else if (project.data == null || project.data!.isEmpty) {
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
