// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:contact_book/features/users/presentation/widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/assets.dart';
import '../../domain/entities/user_entity.dart';
import '../blocs/users_bloc.dart';

class UserListView extends StatelessWidget {
  const UserListView({
    super.key,
    required this.users,
  });
  final List<UserEntity> users;
  @override
  Widget build(BuildContext context) {
    if (users.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.white,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: users.length,
          itemBuilder: (context, index) {
            return buildUserTile(index, context);
          },
        ),
      );
    } else {
      return const Center(child: Text('No Users'));
    }
  }

  Widget buildUserTile(int index, BuildContext context) {
    return UserTile(
      numberId: index + 1,
      userEntity: users[index],
      toggleSelect: (value) {
        // add to selection List
        if (value) {
          context.read<UsersBloc>().usersSelected.add(users[index]);
        } else {
          context.read<UsersBloc>().usersSelected.remove(users[index]);
        }
      },
    );
  }
}
