import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:contact_book/core/constants/colors.dart';
import 'package:contact_book/core/widgets/bread_crumb.dart';
import 'package:contact_book/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import '../blocs/bloc/users_bloc.dart';
import 'users_list_builder.dart';

class UsersBody extends StatelessWidget {
  const UsersBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<UsersBloc>().add(GetAllUsersEvent());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            const SliverToBoxAdapter(child: BreadCrumbNavigator()),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  buildDeleteButton(context),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      child: const Text('Invite new user'),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            SliverToBoxAdapter(
              child: TextField(
                onChanged: (value) {
                  context
                      .read<UsersBloc>()
                      .add(SearchUserEvent(searchKeyword: value));
                },
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                decoration: const InputDecoration(
                  labelText: 'Search',
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            const SliverToBoxAdapter(child: UsersListBuilder()),
          ],
        ),
      ),
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    final userBloc = context.read<UsersBloc>();
    return Expanded(
      child: CustomButton(
        color: const Color(0xffFC766A),
        child: const Text('Delete'),
        onPressed: () {
          if (userBloc.usersSelected.isNotEmpty) {
            AwesomeDialog(
              context: context,
              animType: AnimType.bottomSlide,
              dialogType: DialogType.warning,
              title: 'Are you sure to delete',
              btnOkColor: Colors.red,
              btnCancelColor: COLORS.PRIMARY,
              btnCancelOnPress: () {
                Navigator.pop(context);
              },
              btnOkOnPress: () {
                List<String> usersId =
                    userBloc.usersSelected.map((user) => user.id).toList();
                userBloc.add(DeleteUsersEvent(usersId: usersId));
                userBloc.usersSelected.clear();
              },
            ).show();
          }
        },
      ),
    );
  }
}
