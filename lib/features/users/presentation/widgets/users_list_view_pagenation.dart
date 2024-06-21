import 'package:contact_book/features/users/domain/entities/user_entity.dart';
import 'package:contact_book/features/users/presentation/widgets/user_tile.dart';
import 'package:flutter/material.dart';

import 'custom_pagenation.dart';

class UsersListViewPagination extends StatefulWidget {
  const UsersListViewPagination({
    super.key,
    required this.users,
  });
  final List<UserEntity> users;
  @override
  State<UsersListViewPagination> createState() =>
      _UsersListViewPaginationState();
}

class _UsersListViewPaginationState extends State<UsersListViewPagination> {
  @override
  Widget build(BuildContext context) {
    int totalPages = (widget.users.length / usersPerPage).ceil();
    if (widget.users.isNotEmpty) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: Colors.white,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: currentPageUsers.length,
              itemBuilder: (context, index) {
                return buildUserTile(index);
              },
            ),
          ),
          const SizedBox(height: 24),
          CustomPagenation(
            totalPages: totalPages,
            currentPage: currentPage,
            onPageChange: (pageIndex) {
              setState(() {
                currentPage = pageIndex;
              });
            },
          ),
          const SizedBox(height: 24),
        ],
      );
    } else {
      return const Center(child: Text('No Users'));
    }
  }

  int currentPage = 0;
  final int usersPerPage = 4;
  List<UserEntity> get currentPageUsers {
    /// extract the starting Index By multilplying
    /// the current page by the users on the page
    final startIndex = currentPage * usersPerPage;

    /// extract the end Index By adding
    /// the start index to the users on the page
    final endIndex = startIndex + usersPerPage;

    /// return users in the current page
    final users = widget.users.sublist(
      startIndex,

      /// check the endIndex to avoid an out Range Exception
      endIndex > widget.users.length ? widget.users.length : endIndex,
    );
    return users;
  }

  Widget buildUserTile(int index) {
    int userIndex = (currentPage * usersPerPage) + index;
    return UserTile(
      userEntity: currentPageUsers[index],
      numberId: userIndex + 1,
    );
  }
}
