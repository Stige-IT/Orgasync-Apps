part of "../../../project.dart";

class FormProjectScreen extends ConsumerStatefulWidget {
  final Project? project;
  const FormProjectScreen({super.key, this.project});

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
    if (widget.project != null) {
      _nameCtrl.text = widget.project!.name!;
      _descriptionCtrl.text = widget.project!.description!;
    }
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
        actions: [
          if (widget.project != null)
            IconButton(
              onPressed: _handleDeleteProject,
              icon: const Icon(Icons.delete),
            ),
        ],
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
        onPressed: _handleSaveProject,
        child: const Icon(Icons.check),
      ),
    );
  }

  void _handleSaveProject() {
    final name = _nameCtrl.text;
    final description = _descriptionCtrl.text;
    if (name.isNotEmpty) {
      final companyProjectId =
          ref.read(detailCompanyProjectNotifier).data!.companyProject!.id;
      if (widget.project != null) {
        // update the project
        ref
            .read(updateProjectNotifier.notifier)
            .update(widget.project!.id!, name, description)
            .then((success) {
          if (success) {
            showSnackbar(context, "success_update_project".tr(),
                type: SnackBarType.success);
            Navigator.of(context).pop();
          } else {
            showSnackbar(context, "failed_update_project".tr(),
                type: SnackBarType.error);
          }
        });
      } else {
        // create new project
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
      }
    } else {
      showSnackbar(context, "name_cant_be_empty".tr());
    }
  }

  _handleDeleteProject() {
    // create dialog to confirm delete project
    final companyProjectId =
        ref.read(detailCompanyProjectNotifier).data!.companyProject!.id;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("delete_project".tr()),
        content: Text("confirm_delete_project".tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("cancel".tr()),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref
                  .read(deleteProjectNotifier.notifier)
                  .delete(widget.project!.id!, companyProjectId!)
                  .then((success) {
                if (success) {
                  showSnackbar(context, "success_delete_project".tr(),
                      type: SnackBarType.success);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                } else {
                  showSnackbar(context, "failed_delete_project".tr(),
                      type: SnackBarType.error);
                }
              });
            },
            child: Text("delete".tr()),
          ),
        ],
      ),
    );
  }
}
