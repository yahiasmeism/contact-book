import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';

class DrawerHead extends StatelessWidget {
  const DrawerHead({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(ASSETS.LOGO_WHITE_PATH),
      contentPadding: const EdgeInsets.only(left: 30),
      trailing: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          size: 30,
          Icons.close,
          color: Colors.white,
        ),
      ),
      tileColor: COLORS.PRIMARY,
    );
  }
}
