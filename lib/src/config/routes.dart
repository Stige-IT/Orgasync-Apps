import 'package:flutter/cupertino.dart';
import 'package:orgasync/src/fetaures/auth/auth.dart';
import 'package:orgasync/src/fetaures/company/company.dart';
import 'package:orgasync/src/fetaures/home/home.dart';
import '../fetaures/splash/ui/splash_screen.dart';
import '../fetaures/user/user.dart';

class AppRoute {
  static Map<String, Widget Function(BuildContext)> routes = {
    "/splash": (_) => const SplashScreen(),

    /// AUTHENTICATION PAGES
    "/login": (_) => const LoginScreen(),
    "/register": (_) => const RegisterScreen(),
    "/verification": (context) {
      final arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      return VerificationScreen(arguments["email"], arguments["type"]);
    },
    "/role": (_) => const RoleScreen(),

    /// HOME PAGES
    "/": (_) => const HomeScreen(),

    /// COMPANY PAGE
    "/company/dashboard": (_) => const DashboardScreen(),
    "/company/create": (_) => const RegisterCompanyWidget(),

    /// USER PAGES
    "/profile": (_) => const ProfileScreen(),
    "/profile/form": (_) => const FormProfileScreen(),
    "/profile/my-company": (_) => const MyCompanyScreen(),
  };
}
