part of "../../../project.dart";

class FormCompanyProjectScreen extends ConsumerStatefulWidget {
  const FormCompanyProjectScreen({super.key});

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
    _nameCtrl = TextEditingController();
    _descriptionCtrl = TextEditingController();
    super.initState();
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
      ),
      body: Stack(
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
                )
              ],
            ),
          ),
          if (createLoading) const DialogLoading(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleCreateProject,
        child: const Icon(Icons.check),
      ),
    );
  }

  void _handleCreateProject() {
    final company = ref.watch(detailCompanyNotifier).data;
    final image = ref.watch(imageProvider);
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
