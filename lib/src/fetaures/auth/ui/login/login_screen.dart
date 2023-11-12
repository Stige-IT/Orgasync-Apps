part of '../../auth.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController _emailCtrl;
  late TextEditingController _passwordCtrl;

  @override
  void initState() {
    _emailCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isObsecure = ref.watch(isObsecureProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [
          ButtonSwitchLanguage(),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("assets/images/app_logo.png"),
              ),
              Text("login".tr(),
                  style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 10),
              Text(
                "login_your_account".tr(),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
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
                obsecureText: isObsecure,
                suffixIcon: IconButton(
                  onPressed: () {
                    ref.read(isObsecureProvider.notifier).state = !isObsecure;
                  },
                  icon: Icon(
                    !isObsecure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
                  },
                  child: Text("login".tr()),
                ),
              ),
              // login with google optional

              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text("or_login_with".tr()),
                    const SizedBox(height: 10),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:
                            Image.asset("assets/images/google.png", height: 30),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("dont_have_account".tr()),
                        TextButton(
                          onPressed: () => nextPage(context, "/role"),
                          child: Text("register".tr()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
