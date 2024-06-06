import 'package:contact_book/core/constants/styles.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.title,
    this.onTap,
    this.leading,
  });
  final String title;
  final Function()? onTap;
  final Widget? leading;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      selectedColor: Colors.black,
      selectedTileColor: Colors.grey[300],
      leadingAndTrailingTextStyle: const TextStyle(),
      title: Text(
        title,
        style: STYLES.TEXT_STYLE_18,
      ),
      contentPadding: const EdgeInsets.only(left: 30),
    );
  }
}
