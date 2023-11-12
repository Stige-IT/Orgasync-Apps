part of '../../auth.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                if (context.locale == const Locale("en", "US")) {
                  context.setLocale(const Locale("id"));
                } else {
                  context.setLocale(const Locale("en", "US"));
                }
              },
              child: Text(context.locale.formattedLocale)),
        ],
      ),
    );
  }
}
