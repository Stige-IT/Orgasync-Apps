part of "../../../project.dart";

class FormProjectScreen extends ConsumerStatefulWidget {
  const FormProjectScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FormProjectScreenState();
}

class _FormProjectScreenState extends ConsumerState<FormProjectScreen> {
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
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text("form_project".tr()),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
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
                maxLines: 5,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _handleCreateProject,
          child: const Icon(Icons.check),
        ));
  }

  void _handleCreateProject() {
    final name = _nameCtrl.text;
    final description = _descriptionCtrl.text;
    if (name.isNotEmpty) {
      final companyProjectId =
          ref.read(detailCompanyProjectNotifier).data!.companyProject!.id;
      ref
          .read(createProjectNotifier.notifier)
          .create(
            companyProjectId!,
            name,
            description,
          )
          .then((success) {
        if (success) {
          showSnackbar(context, "success_create_project".tr(),
              type: SnackBarType.success);
          Navigator.of(context).pop();
        } else {
          showSnackbar(context, "failed_create_project".tr(),
              type: SnackBarType.error);
        }
      });
    } else {
      showSnackbar(context, "name_cant_be_empty".tr());
    }
  }
}
