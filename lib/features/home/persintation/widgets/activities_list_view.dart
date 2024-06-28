import 'package:flutter/material.dart';

import '../../domin/entities/activity_entity.dart';
import 'activity_tile.dart';

class ActivitiesListView extends StatelessWidget {
  const ActivitiesListView({super.key, required this.activities});
  final List<ActivityEntity> activities;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activities.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ActivityTile(activityEntity: activities[index]);
      },
    );
  }
}
