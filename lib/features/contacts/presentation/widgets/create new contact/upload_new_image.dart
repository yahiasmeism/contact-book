// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:contact_book/core/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/constants/styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/snackbar_global.dart';

class UploadNewImage extends StatefulWidget {
  const UploadNewImage({
    super.key,
    required this.onUploadNewImage,
    this.initialImage,
  });
  final File? initialImage;
  final Function(File? imageFile) onUploadNewImage;
  @override
  State<UploadNewImage> createState() => _UploadNewImageState();
}

class _UploadNewImageState extends State<UploadNewImage> {
  File? imageFile;
  @override
  void initState() {
    imageFile = widget.initialImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: imageFile != null
              ? FileImage(imageFile!)
              : const AssetImage(ASSETS.PLACEHOLDER),
        ),
        const SizedBox(height: 24),
        Text(
          'JPG or PNG no larger than 5MB',
          style: STYLES.TEXT_STYLE_18
              .copyWith(color: Colors.black.withOpacity(.5)),
        ),
        const SizedBox(height: 24),
        buildUploadImageButton(context),
      ],
    );
  }

  Widget buildUploadImageButton(BuildContext context) {
    final imagePicker = ImagePicker();
    return CustomButton(
      child: const Text('Upload new image'),
      onPressed: () async {
        final pickedImage =
            await imagePicker.pickImage(source: ImageSource.gallery);

        if (pickedImage != null) {
          // initail max size
          const int maxsize = 5 * 1024 * 1024;

          // get image size
          final int imageSize = await pickedImage.length();

          // Check if the image is larger than the maximum size
          if (imageSize > maxsize) {
            SnackBarGlobal.show(
                context, 'The selected image is larger than 5 MB');
          } else {
            setState(() {
              imageFile = File(pickedImage.path);
              widget.onUploadNewImage(imageFile);
            });
          }
        }
      },
    );
  }
}
