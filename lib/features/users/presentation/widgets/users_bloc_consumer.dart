import '../../../../core/widgets/snackbar_global.dart';
import 'user_list_view.dart';
import 'users_list_view_pagenation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/users_bloc.dart';

class UsersBlocConsumer extends StatelessWidget {
  const UsersBlocConsumer({
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
          return const SingleChildScrollView(
              child: Center(child: CircularProgressIndicator()));
        } else if (state is FilterUsersState) {
          return UserListView(users: state.usersFilter);
        } else {
          final users = context.read<UsersBloc>().users;
          return UsersListViewPagination(users: users);
        }
      },
    );
  }
}
