import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:contact_book/features/contacts/presentation/pages/contacts_page.dart';
import '../../../features/home/persintation/pages/home_page.dart';
import '../../constants/colors.dart';
import '../../../features/authentication/presentation/cubits/logout_cubit/logout_cubit.dart';
import '../../../features/authentication/presentation/pages/login_page.dart';
import '../../../features/company/presentation/pages/company_profile_page.dart';
import 'drawer_item.dart';
import '../../../features/users/presentation/pages/users_page.dart';
import '../../../main.dart';
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
            pushPageAndPopDrawer(context, HomePage.name);
          },
        ),
        const CustomDivider(),
        DrawerItem(
          title: 'Contacts',
          onTap: () {
            pushPageAndPopDrawer(context, ContactsPage.name);
          },
        ),
        const CustomDivider(),
        DrawerItem(
          title: 'Company Profile',
          onTap: () {
            pushPageAndPopDrawer(context, CompanyProfilePage.name);
          },
        ),
        const CustomDivider(),
        DrawerItem(
          title: 'Users',
          onTap: () {
            pushPageAndPopDrawer(context, UsersPage.name);
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
          onTap: () {
            pushPageAndPopDrawer(context, CompanyProfilePage.name);
          },
        ),
        buildLogoutButton(context),
      ],
    );
  }

  DrawerItem buildLogoutButton(BuildContext context) {
    return DrawerItem(
      leading: const Icon(Icons.logout, size: 30),
      title: 'Log out',
      onTap: () {
        AwesomeDialog(
          animType: AnimType.bottomSlide,
          dialogType: DialogType.warning,
          context: context,
          title: 'Are you sure to Log out',
          btnOkColor: COLORS.PRIMARY,
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            context.read<LogoutCubit>().logout();
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginPage.name,
              (route) => false,
            );
          },
        ).show();
      },
    );
  }

  pushPageAndPopDrawer(BuildContext context, String nextPageName) {
    Navigator.pop(context);
    final routeObserver = ContactBookApp.routeObserver;
    final currentPage = ModalRoute.of(context)?.settings.name;
    if (routeObserver.isRoutePresent(nextPageName)) {
      Navigator.popUntil(context, ModalRoute.withName(nextPageName));
    } else {
      if (currentPage == HomePage.name) {
        Navigator.pushNamed(context, nextPageName);
      } else {
        Navigator.pushReplacementNamed(context, nextPageName);
      }
    }
  }
}
