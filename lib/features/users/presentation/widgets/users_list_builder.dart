import 'package:contact_book/core/widgets/snackbar_global.dart';
import 'package:contact_book/features/users/domain/entities/user_entity.dart';
import 'package:contact_book/features/users/presentation/blocs/bloc/users_bloc.dart';
import 'package:contact_book/features/users/presentation/widgets/users_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersListBuilder extends StatelessWidget {
  const UsersListBuilder({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersBloc, UsersState>(
      listener: (context, state) {
        if (state is UsersFailure) {
          SnackBarGlobal.show(context, state.message, color: Colors.red);
        } else if (state is UserOperationSuccess) {
          SnackBarGlobal.show(context, state.message, color: Colors.green);
        }
      },
      builder: (context, state) {
        if (state is UsersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserOnSearchState) {
          return UsersListView(users: state.usersFilter);
        } else {
          final List<UserEntity> users = context.read<UsersBloc>().users;
          return UsersListView(users: users);
        }
      },
    );
  }
}
