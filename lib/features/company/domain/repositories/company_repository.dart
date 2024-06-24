import '../../../../core/error/failures.dart';
import '../entities/company_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class CompanyRepository {
  Future<Either<Failure, CompanyEntity>> updateCompanyInfo(
      {required CompanyEntity companyEntity});
  Future<Either<Failure, CompanyEntity>> getCompanyInfo();
}
