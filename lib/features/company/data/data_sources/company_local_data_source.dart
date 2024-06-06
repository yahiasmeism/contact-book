import 'dart:convert';

import 'package:contact_book/core/constants/constant.dart';
import 'package:contact_book/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/company_model.dart';

abstract interface class CompanyLocalDataSource {
  Future<void> storeCompanyInfo(CompanyModel companyModel);
  Future<CompanyModel> getCompanyInfo();
}

class CompanyLocalDataSourceImpl extends CompanyLocalDataSource {
  final SharedPreferences sharedPreferences;

  CompanyLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<CompanyModel> getCompanyInfo() async {
    if (sharedPreferences.containsKey(COMAPNY_KEY)) {
      String jsonEncoded = sharedPreferences.getString(COMAPNY_KEY)!;
      final jsonDecoded = jsonDecode(jsonEncoded);
      return CompanyModel.fromJson(jsonDecoded);
    } else {
      throw EmptyChacheException('Company info not found');
    }
  }

  @override
  Future<void> storeCompanyInfo(CompanyModel companyModel) async {
    Map<String, dynamic> json = companyModel.toJson();
    final jsonEncoded = jsonEncode(json);
    await sharedPreferences.setString(COMAPNY_KEY, jsonEncoded);
  }
}
