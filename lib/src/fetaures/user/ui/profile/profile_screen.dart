part of '../../user.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  void _getData(){
    ref.read(totalMyCompanyNotifier.notifier).getTotal();
  }

  @override
  void initState() {
    Future.microtask(() => _getData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userNotifier);
    return Scaffold(
      appBar: const AppbarWidget(),
      body: RefreshIndicator(
        onRefresh: () async{
          await Future.delayed(const Duration(seconds: 1),(){
            ref.read(userNotifier.notifier).get();
            _getData();
          });
        },
        child: Center(
          child: SizedBox(
            width: context.isDesktop ? context.width * 0.7 : null,
            child: Builder(builder: (_) {
              if (state.isLoading) {
                return const LoadingWidget();
              } else if (state.error != null) {
                return ErrorButtonWidget(state.error!, () {
                  ref.read(userNotifier.notifier).get();
                  _getData();
                });
              } else if (state.data == null) {
                return const EmptyWidget();
              } else {
                return ListView(
                  children: const [
                    ProfileDataWidget(),
                    SettingWidget(),
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
