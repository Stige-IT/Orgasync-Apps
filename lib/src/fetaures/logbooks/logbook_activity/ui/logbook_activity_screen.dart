part of "../logbook_activity.dart";

class LogBookActivityScreen extends ConsumerStatefulWidget {
  final String? idLogBookEmployee;
  final String? idLogBook;
  const LogBookActivityScreen(
      {super.key, this.idLogBookEmployee, this.idLogBook});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LogBookActivityScreenState();
}

class _LogBookActivityScreenState extends ConsumerState<LogBookActivityScreen> {
  States<List<LogBookActivity>> state = States.noState();
  List<LogBookActivity> data = [];

  void _getData() {
    if (widget.idLogBookEmployee != null) {
      ref
          .read(logBookActivityNotifier.notifier)
          .getLogBookActivity(widget.idLogBookEmployee!);
    } else {
      ref
          .read(logBookActivityMeNotifier.notifier)
          .getLogBookActivity(widget.idLogBook!);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _getData());
  }

  @override
  Widget build(BuildContext context) {
    final roleUser = ref.watch(roleInCompanyNotifier).data;
    if (widget.idLogBookEmployee != null) {
      state = ref.watch(logBookActivityNotifier);
      data = state.data ?? [];
    } else {
      state = ref.watch(logBookActivityMeNotifier);
      data = state.data ?? [];
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: InkWell(
            onTap: () => _getData(), child: const Text("Log Book Activity")),
      ),
      body: Stack(
        children: [
          Align(
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
                    return Center(
                        child:
                            ErrorButtonWidget(state.error!, () => _getData()));
                  } else if (data == null || data.isEmpty) {
                    return const Center(child: EmptyWidget());
                  } else {
                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 100),
                      itemCount: data.length,
                      itemBuilder: (_, index) {
                        final logBookActivity = data[index];
                        return ExpansionTile(
                          leading: const Icon(Icons.date_range),
                          title: Text(logBookActivity.month ?? ""),
                          childrenPadding:
                              const EdgeInsets.symmetric(vertical: 10),
                          children: (logBookActivity.activities ?? []).map((e) {
                            return Card(
                              margin: const EdgeInsets.only(bottom: 20.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: context.theme.colorScheme.onBackground
                                      .withOpacity(0.2),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.book),
                                    title: const Text("activity"),
                                    trailing: Text(
                                        "${'total_character'.tr()} : ${e.description!.length}"),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () => _showImage(e),
                                        child: Container(
                                          margin: const EdgeInsets.all(15),
                                          height: context.isMobile ? 50 : 100,
                                          width: context.isMobile ? 100 : 200,
                                          child: Builder(builder: (_) {
                                            if (e.image == null) {
                                              return const Icon(Icons.image);
                                            }
                                            return Image.network(
                                              "${ConstantUrl.BASEIMGURL}/${e.image}",
                                              fit: BoxFit.cover,
                                            );
                                          }),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(e.description ?? ""),
                                          subtitle: Row(
                                            children: [
                                              for (int i = 0; i < 5; i++)
                                                if (i < e.rating!)
                                                  const Icon(Icons.star,
                                                      color: Colors.amber)
                                                else
                                                  const Icon(Icons.star_border)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  ListTile(
                                    dense: true,
                                    title:
                                        Text(e.createdAt!.dateFormatWithDay()),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 20),
                    );
                  }
                }),
              ),
            ),
          ),
          if (ref.watch(addLogBookActivityNotifier).isLoading)
            const DialogLoading()
        ],
      ),
      floatingActionButton: roleUser != Role.owner
          ? FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => FormLogBookActivityScreen(
                    idLogBookEmployee: widget.idLogBookEmployee,
                    idLogbook: widget.idLogBook,
                  ),
                );
              },
              label: Text("add_activity".tr()),
              icon: const Icon(Icons.add),
            )
          : null,
    );
  }

  void _showImage(Activities activities) {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(color: Colors.white),
        insetPadding: EdgeInsets.zero,
        title: Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const CircleAvatar(child: Icon(Icons.close)),
          ),
        ),
        content: SizedBox(
          width: size.width,
          child: PhotoView(
            backgroundDecoration:
                const BoxDecoration(color: Colors.transparent),
            imageProvider: NetworkImage(
              "${ConstantUrl.BASEIMGURL}/${activities.image}",
            ),
          ),
        ),
      ),
    );
  }
}
