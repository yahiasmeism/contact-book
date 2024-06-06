import 'package:contact_book/core/error/failures.dart';
import 'package:contact_book/features/company/domain/entities/company_entity.dart';
import 'package:contact_book/features/company/domain/repositories/company_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateCompanyInfoUseCase {
  CompanyRepository companyRepository;
  UpdateCompanyInfoUseCase({
    required this.companyRepository,
  });
  Future<Either<Failure, CompanyEntity>> call(CompanyEntity companyEntity) {
    return companyRepository.updateCompanyInfo(companyEntity: companyEntity);
  }
}
