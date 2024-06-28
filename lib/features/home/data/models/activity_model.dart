import 'package:contact_book/features/home/domin/entities/activity_entity.dart';

class ActivityModel extends ActivityEntity {
  const ActivityModel({
    required super.id,
    required super.action,
    required super.timestamp,
    required super.contact,
    required super.by,
    required super.companyId,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> jsonData) {
    return ActivityModel(
      id: jsonData['id'],
      action: jsonData['action'],
      timestamp: jsonData['timestamp'],
      contact: jsonData['contact'],
      by: jsonData['by'],
      companyId: jsonData['companyId'],
    );
  }
}
