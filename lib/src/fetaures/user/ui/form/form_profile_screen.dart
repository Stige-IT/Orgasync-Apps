part of "../../user.dart";

class FormProfileScreen extends ConsumerStatefulWidget {
  const FormProfileScreen({super.key});

  @override
  ConsumerState createState() => _FormProfileScreenState();
}

class _FormProfileScreenState extends ConsumerState<FormProfileScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;

  @override
  void initState() {
    _nameCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    Future.microtask(() {
      final userdata = ref.watch(userNotifier).data;
      _nameCtrl.text = userdata?.name ?? "";
      _emailCtrl.text = userdata?.email ?? "";
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final image = ref.watch(imageProvider);
    final userdata = ref.watch(userNotifier).data;
    final isLoading = ref.watch(editUserNotifier).isLoading;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text("profile".tr()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(25.0),
        children: [
          Container(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Builder(builder: (_) {
                  if (image != null) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: FileImage(image),
                      ),
                    );
                  }
                  return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: userdata?.image != null
                          ? CircleAvatarNetwork(userdata?.image, size: 140)
                          : ProfileWithName(userdata?.name ?? "  ", size: 140));
                }),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: CircleAvatar(
                    backgroundColor: context.theme.colorScheme.background,
                    foregroundColor: context.theme.colorScheme.onBackground,
                    child: IconButton(
                      onPressed: () async {
                        final newImage = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 50,
                        );
                        if (newImage != null) {
                          ref.read(imageProvider.notifier).state =
                              File(newImage.path);
                        }
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Form(
            key: formKey,
            child: Column(
              children: [
                FieldInput(
                  title: "name".tr(),
                  hintText: "input_name".tr(),
                  controllers: _nameCtrl,
                ),
                FieldInput(
                  title: "email".tr(),
                  hintText: "input_email".tr(),
                  controllers: _emailCtrl,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            width: double.infinity,
            child: FilledButton(
              onPressed: _handleUpdate,
              child: isLoading ? const LoadingWidget() : Text("save".tr()),
            ),
          ),
        ],
      ),
    );
  }

  void _handleUpdate() {
    if (formKey.currentState!.validate()) {
      ref
          .read(editUserNotifier.notifier)
          .edit(
            name: _nameCtrl.text,
            email: _emailCtrl.text,
            image: ref.watch(imageProvider),
          )
          .then((value) {
        if (value) {
          Navigator.of(context).pop();
          showSnackbar(context, "success".tr(), type: SnackBarType.success);
        } else {
          final errorMessage = ref.watch(editUserNotifier).error!;
          showSnackbar(context, errorMessage, type: SnackBarType.error);
        }
      });
    }
  }
}
