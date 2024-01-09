part of "../../logbook.dart";

class FormLogbookScreen extends ConsumerStatefulWidget {
  const FormLogbookScreen({super.key});

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
  }

  @override
  void dispose() {
    super.dispose();
    _nameCtrl.dispose();
    _descriptionCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final periodeStart = ref.watch(selectedStartDateProvider);
    final periodeEnd = ref.watch(selectedEndDateProvider);
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(minWidth: 0, maxWidth: 1024),
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
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
                      FieldInput(
                        title: "description".tr(),
                        hintText: "input_description".tr(),
                        controllers: _descriptionCtrl,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(
                                "periode_start".tr(),
                                style: const TextStyle(fontSize: 12),
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
                          const Icon(Icons.arrow_forward),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                "periode_start".tr(),
                                style: const TextStyle(fontSize: 12),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: FilledButton(
                      onPressed: _handleSave,
                      child: Text("save".tr()),
                    ),
                  ),
                )
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
        name: _nameCtrl.text,
        description: _descriptionCtrl.text,
        periodeStart: periodeStart.toString(),
        periodeEnd: periodeEnd.toString(),
      );
      ref.read(addLogBookNotifier.notifier).addLogBook(logBook).then((success) {
        if (!success) {
          final error = ref.watch(addLogBookNotifier).error;
          showSnackbar(context, error!, type: SnackBarType.error);
        }
      });
    } else {
      showSnackbar(context, "please_fill_the_form".tr());
    }
  }
}