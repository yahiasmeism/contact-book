import 'package:contact_book/core/constants/assets.dart';
import 'package:contact_book/features/users/domain/entities/user_entity.dart';
import 'package:contact_book/features/users/presentation/blocs/bloc/users_bloc.dart';
import 'package:contact_book/features/users/presentation/widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersListView extends StatelessWidget {
  const UsersListView({
    super.key,
    required this.users,
  });
  final List<UserEntity> users;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.white,
      ),
      child: users.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: users.length,
              itemBuilder: (context, index) {
                return UserTile(
                  image: const AssetImage(ASSETS.PERSON),
                  name: '${users[index].firstName} ${users[index].lastName}',
                  numberId: index + 1,
                  status: users[index].status,
                  toggleSelect: (value) {
                    // add to selection List
                    if (value) {
                      context.read<UsersBloc>().usersSelected.add(users[index]);
                    } else {
                      context
                          .read<UsersBloc>()
                          .usersSelected
                          .remove(users[index]);
                    }
                  },
                  email: users[index].email,
                  phone: users[index].phoneNumber,
                );
              },
            )
          : const Center(child: Text('No Users')),
    );
  }
}
