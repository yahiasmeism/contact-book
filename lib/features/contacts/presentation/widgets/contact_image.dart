import 'dart:io';

import 'package:contact_book/core/constants/assets.dart';
import 'package:contact_book/features/contacts/domain/entities/contact_entity.dart';
import 'package:contact_book/features/contacts/presentation/widgets/image_loading_indecator.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/image_cache_manager.dart';

class ContactImage extends StatelessWidget {
  const ContactImage(
      {super.key,
      required this.contact,
      this.radius = 50,
      this.onChangeImageFile});
  final ContactEntity contact;
  final double radius;
  final Function(File? file)? onChangeImageFile;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ImageCacheManager.getImage(imageUrl: contact.imageUrl ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final imageFile = snapshot.data!;
          if (onChangeImageFile != null) {
            onChangeImageFile!(imageFile);
          }
          return CircleAvatar(
            radius: radius,
            backgroundImage: FileImage(imageFile),
          );
        } else if (snapshot.hasError) {
          return CircleAvatar(
            radius: radius,
            backgroundImage: const AssetImage(ASSETS.PLACEHOLDER),
          );
        } else {
          return ImageLoadingIndecator(radius: radius);
        }
      },
    );
  }
}
