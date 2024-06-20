import 'package:contact_book/core/constants/assets.dart';
import 'package:contact_book/core/constants/colors.dart';
import 'package:contact_book/core/constants/styles.dart';
import 'package:contact_book/core/widgets/custom_checkbox.dart';
import 'package:contact_book/core/widgets/custom_divider.dart';
import 'package:contact_book/features/users/domain/entities/user_entity.dart';
import 'package:contact_book/features/users/presentation/blocs/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/user_details_page.dart';
import 'star_favorite_toggle.dart';
import 'status_text.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.numberId,
    this.toggleSelect,
    this.toggleFavorite,
    required this.userEntity,
  });
  final UserEntity userEntity;
  final int numberId;
  final Function(bool value)? toggleSelect;
  final Function(bool value)? toggleFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          UserDetailsPage.name,
          arguments: userEntity,
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Transform.scale(
              scale: 1.2,
              child: CustomCheckBox(
                onChange: toggleSelect,
                initalValue: context
                    .read<UsersBloc>()
                    .usersSelected
                    .contains(userEntity),
              )),
          StarFavoriteToggle(
            initalValue: false,
            favoriteToggle: (value) {},
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
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(ASSETS.PERSON),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${userEntity.firstName} ${userEntity.lastName}',
                      style: STYLES.TEXT_STYLE_24.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: StatusText(status: userEntity.status ?? ''),
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
                      '#${numberId.toString().padLeft(3, '0')}',
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
            userEntity.email,
            style: STYLES.TEXT_STYLE_16.copyWith(color: Colors.black54),
          ),
          const SizedBox(height: 4),
          Text(
            userEntity.phoneNumber,
            style: STYLES.TEXT_STYLE_16.copyWith(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
