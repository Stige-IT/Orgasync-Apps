part of "../home.dart";

class CompaniesWidget extends ConsumerStatefulWidget {
  const CompaniesWidget({super.key});

  @override
  ConsumerState createState() => _CompaniesWidgetState();
}

class _CompaniesWidgetState extends ConsumerState<CompaniesWidget> {
  late ScrollController scrollController;

  void _getData(){
    ref.read(companyNotifier.notifier).getCompany(makeLoading: true);
  }

  @override
  void initState() {
    scrollController = ScrollController();
    Future.microtask(() => _getData());
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(companyNotifier);
    return Scrollbar(
      controller: scrollController,
      trackVisibility: true,
      thumbVisibility: true,
      child: Builder(
        builder: (_) {
          if(state.isLoading){
            return const CircularLoading();
          }else if(state.error != null){
            return  ErrorButtonWidget(state.error!, () => _getData());
          }else if(state.data == null || state.data!.isEmpty){
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/empty.png", width: 200),
                const SizedBox(height: 20),
                Text("empty".tr(), style: context.theme.textTheme.bodyLarge)
              ],
            ));
          }else{
            final data = state.data;
            return ListView.builder(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 30),
              itemBuilder: (_, i) => CardCompany(data![i]),
              itemCount: (data ?? []).length,
            );
          }

        }
      ),
    );
  }
}
