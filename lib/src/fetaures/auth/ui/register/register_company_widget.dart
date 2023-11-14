part of '../../auth.dart';

class RegisterCompanyWidget extends ConsumerStatefulWidget {
  const RegisterCompanyWidget({super.key});

  @override
  ConsumerState createState() => _RegisterCompanyWidgetState();
}

class _RegisterCompanyWidgetState extends ConsumerState<RegisterCompanyWidget> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _passwordCtrl;
  late TextEditingController _sizeCtrl;
  late TextEditingController _countryCtrl;

  @override
  void initState() {
    _nameCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
    _sizeCtrl = TextEditingController(text: "0");
    _countryCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _sizeCtrl.dispose();
    _countryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isObsecure = ref.watch(isObsecureProvider);
    final isLoading = ref.watch(registerCompanyNotifier).isLoading;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FieldInput(
              title: "name".tr(),
              hintText: "input_name".tr(),
              controllers: _nameCtrl,
            ),
            FieldInput(
              title: "size_employee".tr(),
              hintText: "input_size".tr(),
              controllers: _sizeCtrl,
              keyboardType: TextInputType.number,
            ),
            FieldInput(
              title: "country".tr(),
              hintText: "input_country".tr(),
              controllers: _countryCtrl,
            ),
            DropdownContainer(
              title: "type_company".tr(),
              value: ref.watch(typeCompanyProvider),
              items: [],
              onChanged: (value) {},
            ),
            FieldInput(
              title: "email".tr(),
              hintText: "input_email".tr(),
              controllers: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
            ),
            FieldInput(
                title: "password".tr(),
                hintText: "input_password".tr(),
                controllers: _passwordCtrl,
                obsecureText: !isObsecure,
                suffixIcon: IconButton(
                  icon: Icon(
                    isObsecure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    ref.read(isObsecureProvider.notifier).state = !isObsecure;
                  },
                )),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _handleRegister,
              child:
                  isLoading ? const CircularLoading() : Text("register".tr()),
            ),
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text("or_register_with".tr()),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:
                          Image.asset("assets/images/google.png", height: 30),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleRegister() {
    if (formKey.currentState!.validate()) {
      final request = CompanyRequest(
        name: _nameCtrl.text,
        email: _emailCtrl.text,
        password: _passwordCtrl.text,
        country: '',
        size: int.parse(_sizeCtrl.text),
        typeCompany: '',
      );
      ref
          .read(registerCompanyNotifier.notifier)
          .register(request)
          .then((success) {
        if (success) {
          nextPage(context, "/login");
        } else {
          final errMessage = ref.watch(registerCompanyNotifier).error;
          showSnackbar(context, errMessage!, type: SnackBarType.error);
        }
      });
    }
  }
}
