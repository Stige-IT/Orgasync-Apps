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
      ),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: SizedBox(
                width: context.isDesktop ? 600 : null,
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage("assets/images/app_logo.png"),
                        ),
                        Text("register".tr(),
                            style: Theme.of(context).textTheme.displayMedium),
                        const SizedBox(height: 10),
                        Text(
                          "register_your_account".tr(),
                          style: const TextStyle(fontSize: 18),
                        ),
                        if (widget.typeUser == TypeUser.employee)
                          const RegisterEmployeeWidget()
                        else
                          const RegisterCompanyWidget(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("have_account".tr()),
                            TextButton(
                              onPressed: () => nextPageRemoveAll(context, "/login"),
                              child: Text("login".tr()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            if (context.isDesktop)
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  width: 600,
                  child: Image.asset("assets/images/join_person1.png", alignment: Alignment.center, fit: BoxFit.cover,),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
