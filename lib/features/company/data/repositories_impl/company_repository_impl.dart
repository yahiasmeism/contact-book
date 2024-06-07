import 'package:contact_book/core/error/exceptions.dart';
import 'package:contact_book/core/error/failures.dart';
import 'package:contact_book/core/network/network_info.dart';
import 'package:contact_book/features/company/data/data_sources/company_local_data_source.dart';
import 'package:contact_book/features/company/data/data_sources/company_remote_data_source.dart';
import 'package:contact_book/features/company/data/models/company_model.dart';

import 'package:contact_book/features/company/domain/entities/company_entity.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/company_repository.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyLocalDataSource companyLocalDataSource;
  final CompanyRemoteDataSource companyRemoteDataSource;
  final NetworkInfo networkInfo;
  CompanyRepositoryImpl({
    required this.companyLocalDataSource,
    required this.companyRemoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, CompanyEntity>> getCompanyInfo() async {
    try {
      CompanyModel companyModel;
      bool isConnected = await networkInfo.isConnected;
      if (isConnected) {
        companyModel = await companyRemoteDataSource.getCompanyInfo();
        companyLocalDataSource.storeCompanyInfo(companyModel);
      } else {
        companyModel = await companyLocalDataSource.getCompanyInfo();
      }
      return Right(companyModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFalure(message: e.message));
    } on EmptyChacheException catch (e) {
      return Left(EmptyChacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CompanyEntity>> updateCompanyInfo({
    required CompanyEntity companyEntity,
  }) async {
    CompanyModel companyModel = CompanyModel.fromEntity(companyEntity);
    try {
      companyModel = await companyRemoteDataSource.updateCompanyInfo(
        companyModel: companyModel,
      );

      await companyLocalDataSource.storeCompanyInfo(companyModel);

      return Right(companyModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFalure(message: e.message));
    }
  }
}
