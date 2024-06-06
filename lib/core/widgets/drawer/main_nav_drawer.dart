import 'package:contact_book/core/widgets/drawer/drawer_header.dart';
import 'package:flutter/material.dart';

import 'drawer_menu_items.dart';

class MainNavDrawer extends StatelessWidget {
  const MainNavDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const NavigationDrawer(children: [
      DrawerHead(),
      DrawerMenuItems(),
    ]);
  }
}
