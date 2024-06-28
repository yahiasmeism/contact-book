import 'package:contact_book/core/constants/constant.dart';
import 'package:contact_book/features/home/data/models/activity_model.dart';
import 'package:hive/hive.dart';

abstract interface class ActivitiesLocalDataSource {
  Future<void> storeActivities({required List<ActivityModel> activities});
  Future<List<ActivityModel>> getActivities();
}

class ActivitiesLocalDataSourceImpl extends ActivitiesLocalDataSource {
  late final Box _box;
  ActivitiesLocalDataSourceImpl() {
    _box = Hive.box(APP_BOX);
  }
  @override
  Future<List<ActivityModel>> getActivities() async {
    return _box.values.whereType<ActivityModel>().toList();
  }

  @override
  Future<void> storeActivities(
      {required List<ActivityModel> activities}) async {
    await _box.addAll(activities);
  }
}
