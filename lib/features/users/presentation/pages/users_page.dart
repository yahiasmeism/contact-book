
import 'package:flutter/material.dart';

import '../../../../core/widgets/drawer/main_nav_drawer.dart';
import '../../../../core/widgets/main_app_bar.dart';
import '../widgets/users_body.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});
  static const id = 'Users';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(),
      drawer: const MainNavDrawer(),
      body: const UsersBody(),
    );
  }
}
