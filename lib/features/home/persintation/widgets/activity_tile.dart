import 'package:contact_book/features/home/domin/entities/activity_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityTile extends StatelessWidget {
  const ActivityTile({super.key, required this.activityEntity});
  final ActivityEntity activityEntity;
  @override
  Widget build(BuildContext context) {
    DateFormat originalFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSSS");
    DateFormat newFormat = DateFormat.yMMMMd();
    DateTime dateTime = originalFormat.parse(activityEntity.timestamp ?? '');
    String formattedDate = newFormat.format(dateTime);
    return Row(
      children: [
        Column(
          children: [Text(activityEntity.by), Text(formattedDate)],
        )
      ],
    );
  }
}
