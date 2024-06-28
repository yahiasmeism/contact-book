import 'package:contact_book/features/home/data/models/activity_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helpers/excute_remote_or_local.dart';
import '../../../../core/network/network_info.dart';
import '../../domin/entities/activity_entity.dart';
import '../../domin/repository/home_repository.dart';
import '../date_sources/activities_local_data_source.dart';
import '../date_sources/activities_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final NetworkInfo networkInfo;
  final ActivitiesLocalDataSource local;
  final ActivitiesRemoteDataSource remote;
  HomeRepositoryImpl({
    required this.networkInfo,
    required this.local,
    required this.remote,
  });

  @override
  Future<Either<Failure, List<ActivityEntity>>> getAcitvities() {
    return executeRemoteOrLocal<List<ActivityEntity>>(
      remoteCall: () async {
        final List<ActivityModel> activities = await remote.getActivities();
        await local.storeActivities(activities: activities);
        return activities;
      },
      localCall: local.getActivities,
      networkInfo: networkInfo,
    );
  }
}
