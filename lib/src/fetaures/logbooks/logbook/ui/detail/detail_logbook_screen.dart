part of "../../logbook.dart";

class DetailLogBookScreen extends ConsumerStatefulWidget {
  final String idLogbook;
  const DetailLogBookScreen(this.idLogbook, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailLogBookScreenState();
}

class _DetailLogBookScreenState extends ConsumerState<DetailLogBookScreen> {
  void _getData() {
    ref.read(detailLogBookNotifier.notifier).get(widget.idLogbook);
  }

  @override
  void initState() {
    Future.microtask(() => _getData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(detailLogBookNotifier);
    final data = state.data;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        title: const Text("Detail Log Book"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => FormLogbookScreen(logBook: data),
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
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(
                  const Duration(seconds: 1), () => _getData());
            },
            child: Builder(builder: (_) {
              if (state.isLoading) {
                return const Center(child: LoadingWidget());
              } else if (state.error != null) {
                return ErrorButtonWidget(state.error!, () => _getData());
              } else if (data == null) {
                return const Center(child: EmptyWidget());
              } else {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: context.theme.colorScheme.onBackground
                                .withOpacity(0.2),
                          ),
                        ),
                        child: ListTile(
                          minLeadingWidth: 50,
                          leading: const CircleAvatar(child: Icon(Icons.book)),
                          title: Text(
                            data.name ?? "",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.description!),
                              const SizedBox(height: 10),
                              Text(
                                "Periode: ${data.periodeStart!.dateFormat()} - ${data.periodeEnd!.dateFormat()}",
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        title: Text("member".tr()),
                        trailing: ElevatedButton.icon(
                          onPressed: () =>
                              nextPage(context, "/logbook/employee/form"),
                          icon: const Icon(Icons.add),
                          label: Text("add_member".tr()),
                        ),
                      ),
                      LogBookEmployeeScreen(widget.idLogbook),
                    ],
                  ),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
