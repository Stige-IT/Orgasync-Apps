part of '../../auth.dart';

class RoleScreen extends ConsumerStatefulWidget {
  const RoleScreen({super.key});

  @override
  ConsumerState createState() => _RoleScreenState();
}

class _RoleScreenState extends ConsumerState<RoleScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,

      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: context.isDesktop ? 600 : null,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "welcometo".tr(),
                    style: const TextStyle(
                      height: 1.2,
                      fontSize: 44,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "description_app".tr(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 40),
                    child:
                        Image.asset("assets/images/three_human.png", height: 200),
                  ),
                  Text(
                    "choose_role".tr(),
                    style:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  FilledButton(
                      onPressed: () => nextPage(context, "/register",
                          argument: TypeUser.company),
                      child: Text("company".tr())),
                  const SizedBox(height: 10),
                  FilledButton(
                      onPressed: () => nextPage(context, "/register",
                          argument: TypeUser.employee),
                      child: Text("employee".tr())),
                  SizedBox(height: size.height * 0.1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
