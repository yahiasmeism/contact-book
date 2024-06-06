import 'package:contact_book/core/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

AppBar mainAppBar() {
  return AppBar(
    centerTitle: true,
    title: SvgPicture.asset(ASSETS.LOGO_WHITE_PATH),
  );
}