import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:contact_book/core/constants/colors.dart';
import 'package:contact_book/core/constants/styles.dart';
import 'package:contact_book/features/authentication/presentation/pages/login_page.dart';
import 'package:contact_book/features/users/domain/entities/user_entity.dart';
import 'package:contact_book/features/users/presentation/pages/user_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/authentication/presentation/cubits/logout_cubit/logout_cubit.dart';

List<PopupMenuEntry> popupMenu(BuildContext context, UserEntity user) {
  return <PopupMenuEntry<dynamic>>[
    PopupMenuItem(
      enabled: false,
      child: Text(
        "${user.firstName}${user.lastName}",
        style: STYLES.TEXT_STYLE_16.copyWith(color: Colors.black),
      ),
    ),
    PopupMenuItem(
      enabled: false,
      child: Text(
        user.email,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 14,
        ),
      ),
    ),

    const PopupMenuDivider(),
    // Profile
    PopupMenuItem(
      onTap: () {
        Navigator.popUntil(
          context,
          (route) => route.isFirst,
        );
        Navigator.pushNamed(
          context,
          UserDetailsPage.name,
          arguments: user,
        );
      },
      child: const ListTile(
        leading: Icon(Icons.person),
        title: Text('Profile'),
      ),
    ),

    // LogOut
    buildLogoutItem(context)
  ];
}

PopupMenuItem buildLogoutItem(BuildContext context) {
  return PopupMenuItem(
    onTap: () {
      AwesomeDialog(
        animType: AnimType.bottomSlide,
        dialogType: DialogType.warning,
        context: context,
        title: 'Are you sure to Log out',
        btnOkColor: COLORS.PRIMARY,
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginPage.name,
            (route) => false,
          );
          context.read<LogoutCubit>().logout();
        },
      ).show();
    },
    child: const ListTile(
      leading: Icon(Icons.logout),
      title: Text('Logout'),
    ),
  );
}
