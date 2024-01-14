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
    final loginProvider = ref.watch(loginNotifier);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: const [
          ButtonSwitchLanguage(),
          SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: context.isDesktop ? 600 : null,
            margin:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
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
                          ref.read(isObsecureProvider.notifier).state =
                              !isObsecure;
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
                      height: 50,
                      child: FilledButton(
                        onPressed: _handleLogin,
                        child: loginProvider.isLoading
                            ? const LoadingWidget()
                            : Text("login".tr()),
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
                              child: Image.asset("assets/images/google.png",
                                  height: 30),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("dont_have_account".tr()),
                              TextButton(
                                onPressed: () => nextPage(context, "/register"),
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
          ),
        ),
      ),
    );
  }

  void _handleLogin() {
    if (formKey.currentState!.validate()) {
      ref
          .read(loginNotifier.notifier)
          .login(
            _emailCtrl.text,
            _passwordCtrl.text,
          )
          .then(
        (user) {
          switch (user) {
            case TypeAccount.verified:
              nextPageRemoveAll(context, "/");
              break;
            case TypeAccount.notVerified:
              ref.read(resendCodeNotifier.notifier).resendCode(_emailCtrl.text);
              final errMessage = ref.watch(loginNotifier).error;
              showSnackbar(context, errMessage!);
              nextPage(context, "/verification", argument: {
                "email": _emailCtrl.text,
                "type": TypeVerification.verifyEmail,
              });
              break;
            default:
              final errMessage = ref.watch(loginNotifier).error;
              showSnackbar(context, errMessage!, type: SnackBarType.error);
              break;
          }
        },
      );
    }
  }
}
