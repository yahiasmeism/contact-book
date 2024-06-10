import 'package:contact_book/core/widgets/drawer/main_nav_drawer.dart';
import 'package:contact_book/core/widgets/main_app_bar.dart';
import 'package:contact_book/features/users/domain/entities/user_entity.dart';
import 'package:contact_book/features/users/presentation/blocs/bloc/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});
  static const id = 'UsersPage';
  @override
  Widget build(BuildContext context) {
    final List<UserEntity> users = context.read<UsersBloc>().users;
    return Scaffold(
      appBar: mainAppBar(),
      drawer: const MainNavDrawer(),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index].firstName),
                );
              },
            );
          }
        },
      ),
    );
  }
}
