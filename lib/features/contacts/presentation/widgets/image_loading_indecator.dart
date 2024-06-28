import 'package:contact_book/core/widgets/custom_fading_widget.dart';
import 'package:flutter/material.dart';

class ImageLoadingIndecator extends StatelessWidget {
  const ImageLoadingIndecator({super.key, required this.radius});
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CustomFadingWidget(
        child: CircleAvatar(
      backgroundColor: Colors.grey,
      radius: radius,
    ));
  }
}
