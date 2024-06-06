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
      {required this.sharedPreferences, required this.dio});
  @override
  Future<CompanyModel> getCompanyInfo() async {
    try {
      Response response = await dio.get(
        options: Options(headers: {
          'Authorization':
              'bearer ${sharedPreferences.getString(ACCESS_TOKEN_KEY)}'
        }),
        API.COMPANIES,
      );
      return CompanyModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<CompanyModel> updateCompanyInfo({required CompanyModel companyModel}) async {
    try {
      Response response = await dio.put(
          options: Options(headers: {
            'Authorization':
                'bearer ${sharedPreferences.getString(ACCESS_TOKEN_KEY)}'
          }),
          API.COMPANIES,
          data: companyModel.toJson());

     return CompanyModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }
}
