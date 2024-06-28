import 'package:hive_flutter/adapters.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/constants/messages.dart';
import '../../../../core/error/exceptions.dart';
import '../models/company_model.dart';

abstract interface class CompanyLocalDataSource {
  Future<void> storeCompanyInfo(CompanyModel companyModel);
  Future<CompanyModel> getCompanyInfo();
}

class CompanyLocalDataSourceImpl extends CompanyLocalDataSource {
  CompanyLocalDataSourceImpl();

  @override
  Future<CompanyModel> getCompanyInfo() async {
    final box = Hive.box(APP_BOX);
    if (box.containsKey(COMAPNY_INFO_KEY)) {
      final companyEntity = box.get(COMAPNY_INFO_KEY);
      return CompanyModel.fromEntity(companyEntity);
    } else {
      throw EmptyChacheException(MESSAGES.NOT_FOUND);
    }
  }

  @override
  Future<void> storeCompanyInfo(CompanyModel companyModel) async {
    try {
      final box = Hive.box(APP_BOX);
      await box.put(COMAPNY_INFO_KEY, companyModel);
    } on HiveError catch (e) {
      throw DatabaseException(e.message);
    }
  }
}
