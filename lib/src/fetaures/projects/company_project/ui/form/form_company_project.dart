part of "../../../project.dart";

class FormCompanyProjectScreen extends ConsumerStatefulWidget {
  final CompanyProject? companyProject;
  const FormCompanyProjectScreen({super.key, this.companyProject});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FormCompanyProjectScreenState();
}

class _FormCompanyProjectScreenState
    extends ConsumerState<FormCompanyProjectScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _descriptionCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController();
    _descriptionCtrl = TextEditingController();
    if (widget.companyProject != null) {
      _nameCtrl.text = widget.companyProject?.name ?? "";
      _descriptionCtrl.text = widget.companyProject?.description ?? "";
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final image = ref.watch(imageProvider);
    final createLoading = ref.watch(createCompanyProjectNotifier).isLoading;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "project".tr(),
            style: context.theme.textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            if (widget.companyProject != null)
              IconButton(
                onPressed: _handleDeleteProject,
                icon: const Icon(Icons.delete),
              ),
          ]),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(minWidth: 0, maxWidth: 1024),
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        final newImage = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (newImage != null) {
                          ref.read(imageProvider.notifier).state =
                              File(newImage.path);
                        }
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            color: context.theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: context.theme.colorScheme.onBackground
                                    .withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Builder(builder: (_) {
                          if (image != null) {
                            return Image.file(image, fit: BoxFit.cover);
                          } else if (widget.companyProject?.image != null) {
                            return Image.network(
                              "${ConstantUrl.BASEIMGURL}/${widget.companyProject?.image}",
                              fit: BoxFit.cover,
                            );
                          }
                          return const Icon(Icons.image, color: Colors.white);
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FieldInput(
                      title: "name_project".tr(),
                      hintText: "input_name".tr(),
                      controllers: _nameCtrl,
                    ),
                    FieldInput(
                      title: "description_project".tr(),
                      hintText: "input_description".tr(),
                      controllers: _descriptionCtrl,
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                    ),
                    const SizedBox(height: 25.0),
                    if (context.isDesktop)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.all(20.0),
                          ),
                          onPressed: _handleSaveProject,
                          child: Text("save".tr()),
                        ),
                      ),
                  ],
                ),
              ),
              if (createLoading) const DialogLoading(),
            ],
          ),
        ),
      ),
      floatingActionButton: context.isMobile
          ? FloatingActionButton(
              onPressed: _handleSaveProject,
              child: const Icon(Icons.check),
            )
          : null,
    );
  }

  void _handleDeleteProject() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("delete_project".tr()),
        content: Text("delete_project_confirm".tr()),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text("cancel".tr()),
          ),
          TextButton(
            onPressed: () {
              final companyId = ref.read(detailCompanyNotifier).data!.id;
              Navigator.of(context).pop();
              ref
                  .read(deleteCompanyProjectNotifier.notifier)
                  .delete(companyId!, widget.companyProject!.id!)
                  .then((success) {
                if (success) {
                  showSnackbar(context, "delete_project_success".tr(),
                      type: SnackBarType.success);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                } else {
                  final error = ref.watch(deleteCompanyProjectNotifier).error!;
                  showSnackbar(context, error, type: SnackBarType.error);
                }
              });
            },
            child: Text("delete".tr()),
          ),
        ],
      ),
    );
  }

  void _handleSaveProject() {
    final company = ref.watch(detailCompanyNotifier).data;
    final image = ref.watch(imageProvider);
    if (widget.companyProject != null) {
      final companyProjectId = widget.companyProject!.id;
      ref
          .read(updateCompanyProjectNotifier.notifier)
          .update(
            companyProjectId!,
            name: _nameCtrl.text,
            description: _descriptionCtrl.text,
            image: image,
          )
          .then((success) {
        if (success) {
          showSnackbar(context, "update_project_success".tr(),
              type: SnackBarType.success);
          Navigator.of(context).pop();
        } else {
          final error = ref.watch(updateCompanyProjectNotifier).error!;
          showSnackbar(context, error, type: SnackBarType.error);
        }
      });
    } else {
      ref
          .read(createCompanyProjectNotifier.notifier)
          .create(
            company!.id!,
            name: _nameCtrl.text,
            description: _descriptionCtrl.text,
            image: image,
          )
          .then((success) {
        if (success) {
          showSnackbar(context, "create_project_success".tr(),
              type: SnackBarType.success);
          Navigator.of(context).pop();
        } else {
          showSnackbar(context, "create_project_failed".tr(),
              type: SnackBarType.error);
        }
      });
    }
  }
}
