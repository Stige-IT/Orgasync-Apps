part of '../../auth.dart';

class RoleScreen extends ConsumerWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: const [
          ButtonSwitchLanguage(),
          SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
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
                      Image.asset("assets/images/three_human.png", height: 150),
                ),
                Text(
                  "choose_role".tr(),
                  style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      context.setLocale(const Locale("id"));
                    },
                    child: Text("company".tr())),
                const SizedBox(height: 5),
                ElevatedButton(
                    onPressed: () {
                      context.setLocale(const Locale("en", "US"));
                    },
                    child: Text("employee".tr())),
                SizedBox(height: size.height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
