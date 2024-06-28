import 'package:contact_book/core/constants/assets.dart';
import 'package:contact_book/features/contacts/domain/entities/contact_entity.dart';
import 'package:contact_book/features/contacts/presentation/managers/contact_image_cubit/contact_image_cubit.dart';
import 'package:contact_book/features/contacts/presentation/widgets/loading/image_loading_indecator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    context.read<ContactImageCubit>().getContactImage(contact: contact);
    return BlocBuilder<ContactImageCubit, ContactImageState>(
      builder: (context, state) {
        if (state is ContactImageLoading) {
          return ImageLoadingIndecator(radius: radius);
        } else if (state is ContactImageLoaded) {
          final image = context.read<ContactImageCubit>().image;
          return CircleAvatar(
            radius: radius,
            backgroundImage: MemoryImage(image!),
          );
        } else {
          return CircleAvatar(
            radius: radius,
            backgroundImage: const AssetImage(ASSETS.PLACEHOLDER),
          );
        }
      },
    );
  }
}






//     return FutureBuilder(
//       future: ImageCacheManager.getImage(imageUrl: contact.imageUrl ?? ''),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done &&
//             snapshot.hasData) {
  //  if (onChangeImageFile != null) {
          //   onChangeImageFile!(imageFile);
          // }
//           final imageFile = snapshot.data!;
//         } else if (snapshot.hasError) {
//           return CircleAvatar(
//             radius: radius,
//             backgroundImage: const AssetImage(ASSETS.PLACEHOLDER),
//           );
//         } else {
//           return ImageLoadingIndecator(radius: radius);
//         }
//       },
//     );
//   }
// }
