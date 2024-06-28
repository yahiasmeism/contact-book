import 'package:contact_book/features/contacts/domain/entities/contact_entity.dart';
import 'package:contact_book/features/contacts/presentation/pages/contact_details_page.dart';
import 'package:contact_book/features/contacts/presentation/widgets/contact_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/widgets/custom_checkbox.dart';
import '../../../../core/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/star_favorite_toggle.dart';
import '../../../../core/widgets/status_text.dart';
import '../managers/contacts_bloc/contacts_bloc.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    super.key,
    required this.contact,
  });
  final ContactEntity contact;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ContactDetailsPage.name,
          arguments: contact,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: COLORS.BORDER),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // top section
            buildTopSection(context),
            const CustomDivider(),
            // center section
            buildCenterSection(),
            const CustomDivider(
              indent: 25,
              endIndent: 25,
            ),
            // bottom section
            buildBottomSection()
          ],
        ),
      ),
    );
  }

  Padding buildTopSection(BuildContext context) {
    ContactsBloc contactsBloc = context.read<ContactsBloc>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Transform.scale(
              scale: 1.2,
              child: CustomCheckBox(
                onChange: (value) {
                  if (value) {
                    contactsBloc.contactsSelected.add(contact);
                  } else {
                    contactsBloc.contactsSelected.remove(contact);
                  }
                },
                initalValue: contactsBloc.contactsSelected.contains(contact),
              )),
          StarFavoriteToggle(
            initalValue: contact.isFavorite ?? false,
            favoriteToggle: (value) {
              contactsBloc.add(ToggleFavoriteEvent(contact: contact));
            },
          ),
        ],
      ),
    );
  }

  Padding buildCenterSection() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 12),
                    ContactImage(contact: contact),
                    const SizedBox(height: 12),
                    Text(
                      "${contact.firstName} ${contact.lastName}",
                      style: STYLES.TEXT_STYLE_24.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: StatusText(status: contact.status ?? ''),
                ),
                Positioned(
                  top: 5,
                  left: 5,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xffE0E0E0),
                    ),
                    child: Text(
                      '#${contact.id.toString().padLeft(3, '0')}',
                      style: const TextStyle(
                        color: Color(0xff868686),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text(
            contact.email,
            style: STYLES.TEXT_STYLE_16.copyWith(color: Colors.black54),
          ),
          const SizedBox(height: 4),
          Text(
            contact.phoneNumber,
            style: STYLES.TEXT_STYLE_16.copyWith(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
