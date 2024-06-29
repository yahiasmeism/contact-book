import 'drawer/main_nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/assets.dart';
import 'app_bar_popup_menu/popup_button.dart';

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
        appBar: myAppBAr(context),
        body: body,
      ),
    );
  }

  AppBar myAppBAr(BuildContext context) {
    return AppBar(
      actions: const <Widget>[PopupButton()],
      centerTitle: true,
      title: SvgPicture.asset(ASSETS.LOGO_WHITE_PATH),
    );
  }
}
