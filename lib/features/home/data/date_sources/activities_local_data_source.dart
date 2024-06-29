import 'package:contact_book/core/constants/constant.dart';
import 'package:contact_book/features/home/domin/entities/activity_entity.dart';
import 'package:hive/hive.dart';

abstract interface class ActivitiesLocalDataSource {
  Future<void> storeActivities({required List<ActivityEntity> activities});
  Future<List<ActivityEntity>> getActivities();
}

class ActivitiesLocalDataSourceImpl extends ActivitiesLocalDataSource {
  late final Box _box;
  ActivitiesLocalDataSourceImpl() {
    _box = Hive.box(APP_BOX);
  }
  @override
  Future<List<ActivityEntity>> getActivities() async {
    final List<ActivityEntity> activities = [];
    final keys = _box.keys.map((k) => k.toString()).toList();
    final List<String> filterActivitiessKey =
        keys.where((k) => k.startsWith('Activities')).toList();

    for (var key in filterActivitiessKey) {
      if (_box.containsKey(key)) {
        final activity = await _box.get(key) as ActivityEntity?;
        if (activity != null) {
          activities.add(activity);
        }
      }
    }

    return activities;
  }

  @override
  Future<void> storeActivities(
      {required List<ActivityEntity> activities}) async {
    for (var activity in activities) {
      await _box.put('Activities/${activity.id}', activity);
    }
  }
}
