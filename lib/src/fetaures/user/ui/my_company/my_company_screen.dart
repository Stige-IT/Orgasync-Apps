part of "../../user.dart";

class MyCompanyScreen extends ConsumerStatefulWidget {
  const MyCompanyScreen({super.key});

  @override
  ConsumerState createState() => _MyCompanyScreenState();
}

class _MyCompanyScreenState extends ConsumerState<MyCompanyScreen> {
  void _getData() {
    ref.read(companyNotifier.notifier).getCompany(makeLoading: true);
  }

  @override
  void initState() {
    Future.microtask(() => _getData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(companyNotifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.colorScheme.background,
        title: Text("my_company".tr()),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          await Future.delayed(const Duration(seconds: 1),()=> _getData());
        },
        child: Builder(
          builder: (_) {
            if (state.isLoading) {
              return const LoadingWidget();
            } else if (state.error != null) {
              return ErrorButtonWidget(state.error!, () => _getData());
            } else if (state.data == null || state.data!.isEmpty) {
              return const EmptyWidget();
            } else {
              final data = state.data;
              return GridView.builder(
                padding: const EdgeInsets.all(10.0),
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: (data ?? []).length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (_, i) {
                  final company = state.data?[i];
                  return CardCompany(
                    company: company,
                    color: colors[Random().nextInt(9)],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
