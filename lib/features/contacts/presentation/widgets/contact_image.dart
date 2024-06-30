import 'package:contact_book/core/constants/assets.dart';
import 'package:contact_book/features/contacts/domain/entities/contact_entity.dart';
import 'package:contact_book/features/contacts/presentation/managers/contact_image_cubit/contact_image_cubit.dart';
import 'package:contact_book/features/contacts/presentation/widgets/loading/image_loading_indecator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/service_locator.dart' as di;

class ContactImage extends StatelessWidget {
  const ContactImage({
    super.key,
    required this.contact,
    this.radius = 50,
  });
  final ContactEntity contact;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.sl<ContactImageCubit>()..loadImage(contact: contact),
      child: BlocBuilder<ContactImageCubit, ContactImageState>(
        builder: (context, state) {
          if (state is ContactImageLoading) {
            return ImageLoadingIndecator(radius: radius);
          } else if (state is ContactImageLoaded) {
            return CircleAvatar(
              radius: radius,
              backgroundImage: MemoryImage(state.image),
            );
          } else {
            return CircleAvatar(
              radius: radius,
              backgroundImage: const AssetImage(ASSETS.PLACEHOLDER),
            );
          }
        },
      ),
    );
  }
}
