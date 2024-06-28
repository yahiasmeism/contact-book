import 'package:contact_book/features/contacts/presentation/pages/contact_details_page.dart';
import 'package:contact_book/features/contacts/presentation/pages/contacts_page.dart';
import 'package:contact_book/features/contacts/presentation/pages/create_new_contact_page.dart';
import 'package:flutter/material.dart';

import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/authentication/presentation/pages/register_page.dart';
import '../../features/company/presentation/pages/company_profile_page.dart';
import '../../features/contacts/presentation/pages/send_email_page.dart';
import '../../features/home/persintation/pages/home_page.dart';
import '../../features/home/persintation/pages/splash_page.dart';
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
        ContactsPage.name: (context) => const ContactsPage(),
        CreateNewContactPage.name: (context) => const CreateNewContactPage(),
        ContactDetailsPage.name: (context) => const ContactDetailsPage(),
        SendEmailPage.name: (context) => const SendEmailPage(),
      };
}
