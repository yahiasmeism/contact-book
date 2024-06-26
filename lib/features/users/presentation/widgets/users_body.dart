import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:contact_book/core/widgets/custom_fields/custom_search_field.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/bread_crumb.dart';
import '../../../../core/widgets/custom_button.dart';
import '../blocs/users_bloc.dart';
import '../pages/user_invite_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'users_bloc_consumer.dart';

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
      child: Container(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              const SliverToBoxAdapter(child: BreadCrumbNavigator()),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    buildDeleteButton(context),
                    const SizedBox(width: 16),
                    buildInviteUserButton(context),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                sliver: buildSearchField(context),
              ),
              const SliverToBoxAdapter(child: UsersBlocConsumer())
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchField(BuildContext context) {
    return SliverToBoxAdapter(
      child: CustomSearchField(
        onChanged: (value) {
          if (value.isNotEmpty) {
            context
                .read<UsersBloc>()
                .add(FilterUserEvent(searchKeyword: value));
          } else {
            context.read<UsersBloc>().add(UndoFilterUsersEvent());
          }
        },
      ),
    );
  }

  Widget buildInviteUserButton(BuildContext context) {
    return Expanded(
      child: CustomButton(
        child: const Text('Invite new user'),
        onPressed: () {
          Navigator.pushNamed(context, UserInvitePage.name);
        },
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
              btnCancelOnPress: () {},
              btnOkOnPress: () async {
                userBloc.add(DeleteUsersEvent(users: userBloc.usersSelected));
              },
            ).show();
          }
        },
      ),
    );
  }
}
