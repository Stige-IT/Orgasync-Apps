part of '../../auth.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  final TypeUser typeUser;

  const RegisterScreen(this.typeUser, {super.key});

  @override
  ConsumerState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: const [
          ButtonSwitchLanguage(),
          SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("assets/images/app_logo.png"),
              ),
              Text("register".tr(),
                  style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 10),
              Text(
                "register_your_account".tr(),
                style: const TextStyle(fontSize: 18),
              ),
              const RegisterEmployeeWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
