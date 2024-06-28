import 'package:contact_book/core/constants/styles.dart';
import 'package:contact_book/features/home/persintation/widgets/last_activities_bloc_consumer.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_divider.dart';
import '../pages/activities_page.dart';

class LatestActivities extends StatelessWidget {
  const LatestActivities({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ActivitiesPage.name);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'Latest activities',
                  style: STYLES.TEXT_STYLE_24,
                ),
              ),
            ),
            CustomDivider(),
            SizedBox(height: 32),
            LastActivitiesBlocConsumer(),
          ],
        ),
      ),
    );
  }
}
