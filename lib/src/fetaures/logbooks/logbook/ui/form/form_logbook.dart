part of "../../logbook.dart";

class FormLogbookScreen extends ConsumerStatefulWidget {
  final LogBook? logBook;
  const FormLogbookScreen({super.key, this.logBook});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FormLogbookScreenState();
}

class _FormLogbookScreenState extends ConsumerState<FormLogbookScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _descriptionCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController();
    _descriptionCtrl = TextEditingController();

    /// if logbook not null, set value to controller
    Future.microtask(() {
      if (widget.logBook != null) {
        _nameCtrl.text = widget.logBook!.name!;
        _descriptionCtrl.text = widget.logBook!.description!;
        ref.read(selectedStartDateProvider.notifier).state =
            DateTime.parse(widget.logBook!.periodeStart!);
        ref.read(selectedEndDateProvider.notifier).state =
            DateTime.parse(widget.logBook!.periodeEnd!);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameCtrl.dispose();
    _descriptionCtrl.dispose();
  }

  bool isFilled() {
    final periodeStart = ref.watch(selectedStartDateProvider);
    final periodeEnd = ref.watch(selectedEndDateProvider);
    return _nameCtrl.text.isNotEmpty &&
        _descriptionCtrl.text.isNotEmpty &&
        periodeStart != null &&
        periodeEnd != null;
  }

  @override
  Widget build(BuildContext context) {
    final periodeStart = ref.watch(selectedStartDateProvider);
    final periodeEnd = ref.watch(selectedEndDateProvider);
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(minWidth: 0, maxWidth: 720),
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: context.theme.colorScheme.onBackground,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text(
                    "LogBook",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    onPressed: Navigator.of(context).pop,
                    icon: const Icon(Icons.close),
                  ),
                ),
                const Divider(),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FieldInput(
                        title: "name".tr(),
                        hintText: "input_name".tr(),
                        controllers: _nameCtrl,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ValueListenableBuilder(
                          valueListenable: _nameCtrl,
                          builder: (_, value, __) {
                            if (value.text.isEmpty) {
                              return Text(
                                "*name_required".tr(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                      FieldInput(
                        title: "description".tr(),
                        hintText: "input_description".tr(),
                        controllers: _descriptionCtrl,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ValueListenableBuilder(
                          valueListenable: _descriptionCtrl,
                          builder: (_, value, __) {
                            if (value.text.isEmpty) {
                              return Text(
                                "*description_required".tr(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "periode_start".tr(),
                                style: const TextStyle(fontSize: 10),
                              ),
                              subtitle: Text(
                                periodeStart?.toString().dateFormat() ?? "-",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              trailing: IconButton(
                                onPressed: () async {
                                  final date = await getDatePicker(context);
                                  if (date != null) {
                                    ref
                                        .read(
                                            selectedStartDateProvider.notifier)
                                        .state = date;
                                  }
                                },
                                icon: const Icon(Icons.date_range),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(Icons.arrow_forward),
                          ),
                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "periode_start".tr(),
                                style: const TextStyle(fontSize: 10),
                              ),
                              subtitle: Text(
                                periodeEnd?.toString().dateFormat() ?? "-",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () async {
                                  final date = await getDatePicker(context);
                                  if (date != null) {
                                    ref
                                        .read(selectedEndDateProvider.notifier)
                                        .state = date;
                                  }
                                },
                                icon: const Icon(Icons.date_range),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: widget.logBook != null
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.end,
                  children: [
                    if (widget.logBook != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: 120,
                          height: 50,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                              foregroundColor: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              ref
                                  .watch(deleteLogBookNotifier.notifier)
                                  .delete(widget.logBook!.id!)
                                  .then(
                                (success) {
                                  if (success) {
                                    showSnackbar(
                                        context, "success_delete".tr());
                                    Navigator.of(context).pop();
                                  } else {
                                    final error =
                                        ref.watch(deleteLogBookNotifier).error;
                                    showSnackbar(context, error!,
                                        type: SnackBarType.error);
                                  }
                                },
                              );
                            },
                            child: Text("remove".tr()),
                          ),
                        ),
                      ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 120,
                        height: 50,
                        child: FilledButton(
                          onPressed: isFilled() ? _handleSave : () {},
                          style: FilledButton.styleFrom(
                              backgroundColor: isFilled()
                                  ? context.theme.colorScheme.primary
                                  : context.theme.colorScheme.primary
                                      .withOpacity(.5)),
                          child: Text("save".tr()),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSave() {
    final periodeStart = ref.watch(selectedStartDateProvider);
    final periodeEnd = ref.watch(selectedEndDateProvider);
    if (_formKey.currentState!.validate() &&
        periodeStart != null &&
        periodeEnd != null) {
      Navigator.of(context).pop();
      final logBook = LogBook(
        id: widget.logBook?.id,
        name: _nameCtrl.text,
        description: _descriptionCtrl.text,
        periodeStart: periodeStart.toString(),
        periodeEnd: periodeEnd.toString(),
      );
      if (widget.logBook != null) {
        /// update logbook
        ref
            .watch(updateLogBookNotifier.notifier)
            .updateLogBook(logBook)
            .then((success) {
          if (success) {
            showSnackbar(context, "success_update".tr());
          } else {
            final error = ref.watch(updateLogBookNotifier).error;
            showSnackbar(context, error!, type: SnackBarType.error);
          }
        });
      } else {
        /// create logbook
        ref
            .read(addLogBookNotifier.notifier)
            .addLogBook(logBook)
            .then((success) {
          if (!success) {
            final error = ref.watch(addLogBookNotifier).error;
            showSnackbar(context, error!, type: SnackBarType.error);
          }
        });
      }
    }
  }
}
