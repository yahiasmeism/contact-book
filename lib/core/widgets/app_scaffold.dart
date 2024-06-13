import 'package:contact_book/core/widgets/drawer/main_nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/assets.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.body,
  });
  final Widget? body;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: const MainNavDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: SvgPicture.asset(ASSETS.LOGO_WHITE_PATH),
        ),
        body: body,
      ),
    );
  }
}
