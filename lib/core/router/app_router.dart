import 'package:flutter/material.dart';

import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/authentication/presentation/pages/register_page.dart';
import '../../features/company/presentation/pages/company_profile_page.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/home/pages/splash_page.dart';
import '../../features/users/presentation/pages/user_details_page.dart';
import '../../features/users/presentation/pages/user_invite_page.dart';
import '../../features/users/presentation/pages/users_page.dart';

abstract class AppRouter {
  static const String initRoute = SplashPage.name;
  static Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        SplashPage.name: (context) => const SplashPage(),
        LoginPage.name: (context) => const LoginPage(),
        RegisterPage.name: (context) => const RegisterPage(),
        HomePage.name: (context) => const HomePage(),
        CompanyProfilePage.name: (context) => const CompanyProfilePage(),
        UsersPage.name: (context) => const UsersPage(),
        UserInvitePage.name: (context) => const UserInvitePage(),
        UserDetailsPage.name: (context) => const UserDetailsPage(),
      };
}
