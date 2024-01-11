part of "../logbook.dart";

class LogBookScreen extends ConsumerStatefulWidget {
  final String idCompany;
  const LogBookScreen(this.idCompany, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogBookScreenState();
}

class _LogBookScreenState extends ConsumerState<LogBookScreen> {
  void _getData() async {
    ref.read(logBookNotifier.notifier).refresh(widget.idCompany);
  }

  @override
  void initState() {
    Future.microtask(() => _getData());
    super.initState();
  }

  String _periode(LogBook logBook) {
    return "${logBook.periodeStart!.dateFormat()} - ${logBook.periodeEnd!.dateFormat()}";
  }

  @override
  Widget build(BuildContext context) {
    final roleUser = ref.watch(roleInCompanyNotifier).data;
    final state = ref.watch(logBookNotifier);
    final data = state.data;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: () => _getData(),
          child: const Text("LogBook"),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1), () => _getData());
        },
        child: Builder(builder: (_) {
          if (state.isLoading) {
            return const Center(child: LoadingWidget());
          } else if (state.error != null) {
            return ErrorButtonWidget(state.error!, () => _getData());
          } else if (data == null || data.isEmpty) {
            return const Center(child: EmptyWidget());
          } else {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemCount: data.length,
              itemBuilder: (_, index) {
                final logBook = data[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: context.theme.colorScheme.onBackground
                          .withOpacity(0.2),
                    ),
                  ),
                  child: ListTile(
                    onTap: () {
                      if (roleUser == Role.owner) {
                        nextPage(context, "/logbook/detail",
                            argument: logBook.id);
                      } else {
                        nextPage(context, "/activity",
                            argument: {"id_logbook": logBook.id});
                      }
                    },
                    leading: const CircleAvatar(child: Icon(Icons.book)),
                    title: Text(logBook.name ?? ""),
                    subtitle: Text(
                      logBook.description ?? "",
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: Text(_periode(logBook)),
                  ),
                );
              },
              separatorBuilder: (_, i) => const SizedBox(height: 7),
            );
          }
        }),
      ),
      floatingActionButton: roleUser != Role.owner
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const FormLogbookScreen(),
                );
              },
              label: Text("create_new".tr()),
              icon: const Icon(Icons.add),
            ),
    );
  }
}
