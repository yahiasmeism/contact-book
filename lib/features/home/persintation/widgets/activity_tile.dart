import 'package:contact_book/core/constants/styles.dart';
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
    DateTime dateTime = originalFormat.parse(activityEntity.timestamp);
    String formattedDate = newFormat.format(dateTime);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activityEntity.contact,
                  style: STYLES.TEXT_STYLE_20,
                ),
                const SizedBox(height: 16),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    color: Colors.black38,
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              buildAction(),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey[100],
                ),
                child: Text(
                  activityEntity.by,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildAction() {
    Color actionColor = Colors.grey;
    switch (activityEntity.action) {
      case 'Add':
        actionColor = Colors.blue;
        break;
      case 'Delete':
        actionColor = Colors.red;
        break;
      case 'Update':
        actionColor = Colors.orange;
        break;
      case 'EmailSent':
        actionColor = Colors.greenAccent;
        break;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 8),
          child: Icon(
            color: actionColor,
            Icons.circle,
            size: 12,
          ),
        ),
        const SizedBox(width: 4), // تعديل المسافة حسب الحاجة
        Text(
          activityEntity.action,
          style: const TextStyle(
            color: Colors.black38,
          ),
        ),
      ],
    );
  }
}
