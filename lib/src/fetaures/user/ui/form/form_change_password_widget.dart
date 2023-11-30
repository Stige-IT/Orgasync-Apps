part of "../../user.dart";

class FormChangePasswordWidget extends ConsumerStatefulWidget {
  const FormChangePasswordWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FormChangePasswordWidgetState();
}

class _FormChangePasswordWidgetState
    extends ConsumerState<FormChangePasswordWidget> {
  late TextEditingController _passwordCtrl;
  late TextEditingController _newPasswordCtrl;

  @override
  void initState() {
    _passwordCtrl = TextEditingController();
    _newPasswordCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _passwordCtrl.dispose();
    _newPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isObsecure = ref.watch(obsecureProvider);
    final isLoading = ref.watch(editPasswordNotifier).isLoading;
    return ListView(
      padding: const EdgeInsets.all(15.0),
      children: [
        ListTile(
          leading: const Icon(Icons.lock_outline),
          title: Text("change_password".tr()),
        ),
        const SizedBox(height: 10),
        FieldInput(
          title: "your_password".tr(),
          hintText: "input_your_password".tr(),
          controllers: _passwordCtrl,
          obsecureText: isObsecure,
        ),
        FieldInput(
          title: "new_password".tr(),
          hintText: "input_new_password".tr(),
          controllers: _newPasswordCtrl,
          obsecureText: isObsecure,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () {
              ref.read(obsecureProvider.notifier).state = !isObsecure;
            },
            icon: const Icon(Icons.check_box_outline_blank),
            label: Text("view_password".tr()),
          ),
        ),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: _handleChangePassword,
          child: isLoading ? const LoadingWidget() : Text("save".tr()),
        )
      ],
    );
  }

  void _handleChangePassword() {
    if (ref.watch(editPasswordNotifier).isLoading) return;
    ref
        .read(editPasswordNotifier.notifier)
        .edit(
          _passwordCtrl.text,
          _newPasswordCtrl.text,
        )
        .then((success) {
      if (success) {
        _newPasswordCtrl.clear();
        _passwordCtrl.clear();
        showSnackbar(context, "success".tr(), type: SnackBarType.success);
      } else {
        final errorMessage = ref.watch(editPasswordNotifier).error!;
        showSnackbar(context, errorMessage, type: SnackBarType.error);
      }
    });
  }
}
