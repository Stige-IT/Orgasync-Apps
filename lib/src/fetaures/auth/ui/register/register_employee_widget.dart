part of '../../auth.dart';

class RegisterEmployeeWidget extends ConsumerStatefulWidget {
  const RegisterEmployeeWidget({super.key});

  @override
  ConsumerState createState() => _RegisterEmployeeWidgetState();
}

class _RegisterEmployeeWidgetState
    extends ConsumerState<RegisterEmployeeWidget> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _passwordCtrl;

  @override
  void initState() {
    _nameCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(registerEmployeeNotifier).isLoading;
    final isObsecure = ref.watch(isObsecureProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FieldInput(
              title: "name".tr(),
              hintText: "Masukkan nama lengkap",
              controllers: _nameCtrl,
            ),
            FieldInput(
              title: "email".tr(),
              hintText: "Masukkan alamat email",
              controllers: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
            ),
            FieldInput(
                title: "password".tr(),
                hintText: "Masukkan password",
                controllers: _passwordCtrl,
                obsecureText: isObsecure,
                suffixIcon: IconButton(
                  icon: Icon(
                    isObsecure ? Icons.visibility_off : Icons.visibility,
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
      ref
          .read(registerEmployeeNotifier.notifier)
          .register(
            name: _nameCtrl.text,
            email: _emailCtrl.text,
            password: _passwordCtrl.text,
          )
          .then((success) {
        if (success) {
          nextPage(context, "/verification", argument: {
            "email": _emailCtrl.text,
            "type": TypeVerification.verifyEmail
          });
        } else {
          final error = ref.watch(registerEmployeeNotifier).error;
          showSnackbar(context, error!, type: SnackBarType.error);
        }
      });
    }
  }
}
