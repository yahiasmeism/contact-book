import 'package:contact_book/core/network/api_client.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/api.dart';
import '../../../../core/constants/constant.dart';
import '../models/activity_model.dart';

abstract class ActivitiesRemoteDataSource {
  Future<List<ActivityModel>> getActivities();
}

class ActivitiesRemoteDataSourceImpl extends ActivitiesRemoteDataSource {
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  ActivitiesRemoteDataSourceImpl(
      {required this.apiClient, required this.sharedPreferences});

  String? get _authToken {
    return sharedPreferences.getString(ACCESS_TOKEN_KEY);
  }

  @override
  Future<List<ActivityModel>> getActivities() async {
    Response response =
        await apiClient.getData(API.ACTIVITIES, token: _authToken);
    List activitiesMap = response.data;
    List<ActivityModel> activities =
        activitiesMap.map((log) => ActivityModel.fromJson(log)).toList();
    return activities;
  }
}
