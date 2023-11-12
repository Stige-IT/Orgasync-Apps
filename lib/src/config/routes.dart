import 'package:flutter/cupertino.dart';
import 'package:orgasync/src/fetaures/auth/auth.dart';
import 'package:orgasync/src/fetaures/home/home.dart';
import '../fetaures/splash/ui/splash_screen.dart';

class AppRoute{
  static Map<String, Widget Function(BuildContext)> routes ={
    "/splash" : (_)=> const SplashScreen(),
    /// AUTHENTICATION PAGES
    "/login" : (_) => const LoginScreen(),
    "/register" : (_) => const RegisterScreen(),

    /// HOME PAGES
    "/" : (_)=> const HomeScreen(),

  };
}