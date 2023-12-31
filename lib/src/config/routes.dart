import 'package:flutter/cupertino.dart';
import 'package:orgasync/src/fetaures/auth/auth.dart';
import 'package:orgasync/src/fetaures/company/company.dart';
import 'package:orgasync/src/fetaures/home/home.dart';
import 'package:orgasync/src/fetaures/projects/project.dart';
import '../fetaures/employee/employee.dart';
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
    "/company/dashboard": (context) {
      final companyId = ModalRoute.of(context)!.settings.arguments as String;
      return DashboardScreen(companyId);
    },
    "/company/create": (_) => const RegisterCompanyWidget(),
    "/company/employee": (context) {
      final companyId = ModalRoute.of(context)!.settings.arguments as String;
      return EmployeeScreen(companyId);
    },

    /// PROJECT PAGE
    "/company/project": (context) {
      final companyId = ModalRoute.of(context)!.settings.arguments as String;
      return CompanyProjectScreen(companyId);
    },
    "/company/project/detail": (context) {
      final companyProjectId =
          ModalRoute.of(context)!.settings.arguments as String;
      return DetailCompanyProjectScreen(companyProjectId);
    },
    "/company/project/form": (context) {
      final companyProject =
          ModalRoute.of(context)!.settings.arguments as CompanyProject?;
      if (companyProject != null) {
        return FormCompanyProjectScreen(companyProject: companyProject);
      } else {
        return const FormCompanyProjectScreen();
      }
    },
    "/company/project/employee": (_) => const ListEmployeeProjectScreen(),
    "/company/project/employee/add": (_) => const AddEmployeeProjectScreen(),

    // PROJECT
    "/project": (_) => const ProjectScreen(),
    "/project/detail": (context) {
      final projectId = ModalRoute.of(context)!.settings.arguments as String;
      return DetailProjectScreen(projectId);
    },
    "/project/form": (context) {
      final project = ModalRoute.of(context)!.settings.arguments as Project?;
      if (project != null) {
        return FormProjectScreen(project: project);
      } else {
        return const FormProjectScreen();
      }
    },

    "/task/detail" :(context){
      final taskId = ModalRoute.of(context)?.settings.arguments as String;
      return DetailTaskScreen(taskId);
    },

    /// USER PAGES
    "/user/search": (context) {
      final companyId = ModalRoute.of(context)!.settings.arguments as String;
      return SearchUserScreen(companyId);
    },
    "/profile": (_) => const ProfileScreen(),
    "/profile/form": (_) => const FormProfileScreen(),
    "/profile/my-company": (_) => const MyCompanyScreen(),
  };
}
