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
          obsecureText: true,
        ),
        FieldInput(
          title: "new_password".tr(),
          hintText: "input_new_password".tr(),
          controllers: _newPasswordCtrl,
          obsecureText: true,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.check_box_outline_blank),
            label: Text(
              "view_password".tr(),
            ),
          ),
        ),
        const SizedBox(height: 20),
        FilledButton(onPressed: () {}, child: Text("save".tr()))
      ],
    );
  }
}
