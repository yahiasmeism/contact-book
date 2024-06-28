import 'package:contact_book/core/network/api_client.dart';

import '../../../../core/constants/api.dart';
import '../../../../core/constants/constant.dart';
import '../models/company_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class CompanyRemoteDataSource {
  Future<CompanyModel> getCompanyInfo();
  Future<CompanyModel> updateCompanyInfo({required CompanyModel companyModel});
}

class CompanyRemoteDataSourceImpl extends CompanyRemoteDataSource {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  CompanyRemoteDataSourceImpl(
      {required this.sharedPreferences, required this.apiClient});

  String? get _authToken {
    return sharedPreferences.getString(ACCESS_TOKEN_KEY);
  }

  @override
  Future<CompanyModel> getCompanyInfo() async {
    Response response = await apiClient.get(API.COMPANIES, token: _authToken);
    return CompanyModel.fromJson(response.data);
  }

  @override
  Future<CompanyModel> updateCompanyInfo(
      {required CompanyModel companyModel}) async {
    Response response = await apiClient.put(
      API.COMPANIES,
      data: companyModel.toJson(),
      token: _authToken,
    );
    return CompanyModel.fromJson(response.data);
  }
}
