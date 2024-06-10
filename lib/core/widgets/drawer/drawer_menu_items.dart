import 'package:contact_book/features/authentication/presentation/cubits/logout_cubit/logout_cubit.dart';
import 'package:contact_book/features/authentication/presentation/pages/login_page.dart';
import 'package:contact_book/features/company/presentation/pages/company_profile_page.dart';
import 'package:contact_book/core/widgets/drawer/drawer_item.dart';
import 'package:contact_book/features/home/pages/home_page.dart';
import 'package:contact_book/features/users/presentation/pages/users_page.dart';
import 'package:contact_book/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../custom_divider.dart';

class DrawerMenuItems extends StatelessWidget {
  const DrawerMenuItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerItem(
          title: 'Home',
          onTap: () {
            pushPageAndPopDrawer(context, HomePage.id);
          },
        ),
        const CustomDivider(),
        DrawerItem(
          title: 'Contacts',
          onTap: () {
            Navigator.pop(context);
          },
        ),
        const CustomDivider(),
        DrawerItem(
          title: 'Company Profile',
          onTap: () {
            pushPageAndPopDrawer(context, CompanyProfilePage.id);
          },
        ),
        const CustomDivider(),
        DrawerItem(
          title: 'Users',
          onTap: () {
            pushPageAndPopDrawer(context, UsersPage.id);
          },
        ),
        const CustomDivider(),
        const DrawerItem(
          title: 'Username',
        ),
        const CustomDivider(),
        DrawerItem(
          leading: const Icon(Icons.person, size: 30),
          title: 'My Profile',
          onTap: () {},
        ),
        DrawerItem(
          leading: const Icon(Icons.logout, size: 30),
          title: 'Log out',
          onTap: () {
            Navigator.pop(context);
            showConfirmLogoutDialog(context);
          },
        ),
      ],
    );
  }

  Future<dynamic> showConfirmLogoutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure to Log out'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  context.read<LogoutCubit>().logout();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginPage.id,
                    (route) => false,
                  );
                },
                child: const Text('Log out')),
          ],
        );
      },
    );
  }

  pushPageAndPopDrawer(BuildContext context, String pageName) {
    Navigator.pop(context);
    final routeObserver = ContactBookApp.routeObserver;
    if (routeObserver.isRoutePresent(pageName)) {
      Navigator.popUntil(context, ModalRoute.withName(pageName));
    } else {
      Navigator.pushNamed(context, pageName);
    }
  }
}
