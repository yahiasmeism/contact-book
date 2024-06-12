import 'package:contact_book/core/constants/api.dart';
import 'package:contact_book/core/constants/constant.dart';
import 'package:contact_book/core/error/exceptions.dart';
import 'package:contact_book/features/company/data/models/company_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class CompanyRemoteDataSource {
  Future<CompanyModel> getCompanyInfo();
  Future<CompanyModel> updateCompanyInfo({required CompanyModel companyModel});
}

class CompanyRemoteDataSourceImpl extends CompanyRemoteDataSource {
  final Dio dio;
  final SharedPreferences sharedPreferences;
  CompanyRemoteDataSourceImpl(
      {required this.sharedPreferences, required this.dio}) {
    // initial dio base option
    String bearerToken =
        'bearer ${sharedPreferences.getString(ACCESS_TOKEN_KEY)}';
    dio.options = BaseOptions(
      headers: {'Authorization': bearerToken},
      connectTimeout: const Duration(seconds: 3),
       sendTimeout: const Duration(seconds: 3),
      receiveTimeout: const Duration(seconds: 3),
    );
  }

  @override
  Future<CompanyModel> getCompanyInfo() async {
    try {
      Response response = await dio.get(API.COMPANIES);
      return CompanyModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<CompanyModel> updateCompanyInfo(
      {required CompanyModel companyModel}) async {
    try {
      Response response =
          await dio.put(API.COMPANIES, data: companyModel.toJson());

      return CompanyModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }
}
