import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'activity_entity.g.dart';

@HiveType(typeId: 3)
class ActivityEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String action;
  @HiveField(2)
  final String timestamp;
  @HiveField(3)
  final String contact;
  @HiveField(4)
  final String by;
  @HiveField(5)
  final int companyId;

  const ActivityEntity({
    required this.id,
    required this.action,
    required this.timestamp,
    required this.contact,
    required this.by,
    required this.companyId,
  });

  @override
  List<Object?> get props {
    return [
      id,
      action,
      timestamp,
      contact,
      by,
      companyId,
    ];
  }
}
