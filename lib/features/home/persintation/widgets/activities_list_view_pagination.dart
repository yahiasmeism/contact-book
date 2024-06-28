import 'package:contact_book/features/home/persintation/widgets/activities_list_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_pagenation.dart';
import '../../domin/entities/activity_entity.dart';

class ActivitiesListViewPagination extends StatefulWidget {
  const ActivitiesListViewPagination({super.key, required this.activities});
  final List<ActivityEntity> activities;
  @override
  State<ActivitiesListViewPagination> createState() =>
      _ActivitiesListViewPaginationState();
}

class _ActivitiesListViewPaginationState
    extends State<ActivitiesListViewPagination> {
  @override
  Widget build(BuildContext context) {
    int totalPages = (widget.activities.length / itemsPerPage).ceil();
    if (widget.activities.isNotEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height - 200,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: ActivitiesListView(activities: currentPageContacts),
            ),
            const Spacer(),
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
        ),
      );
    } else {
      return const Center(child: Text('No Contacts'));
    }
  }

  int currentPage = 0;

  final int itemsPerPage = 7;

  List<ActivityEntity> get currentPageContacts {
    /// extract the starting Index By multilplying
    /// the current page by the users on the page
    final startIndex = currentPage * itemsPerPage;

    /// extract the end Index By adding
    /// the start index to the users on the page
    final endIndex = startIndex + itemsPerPage;

    /// return users in the current page
    final users = widget.activities.sublist(
      startIndex,

      /// check the endIndex to avoid an out Range Exception
      endIndex > widget.activities.length ? widget.activities.length : endIndex,
    );
    return users;
  }
}


/* 
Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),

 */