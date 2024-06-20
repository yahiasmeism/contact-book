import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:contact_book/core/constants/colors.dart';
import 'package:contact_book/core/widgets/bread_crumb.dart';
import 'package:contact_book/core/widgets/custom_button.dart';
import 'package:contact_book/features/users/presentation/blocs/users_bloc.dart';
import 'package:contact_book/features/users/presentation/pages/user_invite_page.dart';
import 'package:contact_book/features/users/presentation/widgets/users_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            const SliverToBoxAdapter(child: UsersBuilder())
          ],
        ),
      ),
    );
  }

  Widget buildSearchField(BuildContext context) {
    return SliverToBoxAdapter(
      child: TextField(
        onChanged: (value) {
          if (value.isNotEmpty) {
            context
                .read<UsersBloc>()
                .add(FilterUserEvent(searchKeyword: value));
          } else {
            context.read<UsersBloc>().add(UndoFilterUsersEvent());
          }
        },
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        decoration: const InputDecoration(
          labelText: 'Search',
        ),
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
              title:
                  'Are you sure to delete ${userBloc.usersSelected.length} user',
              btnOkColor: Colors.red,
              btnCancelColor: COLORS.PRIMARY,
              btnCancelOnPress: () {},
              btnOkOnPress: () {
                List<String> usersId = userBloc.usersSelected
                    .map((user) => user.id ?? '')
                    .toList();
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
