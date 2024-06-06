import 'package:contact_book/core/error/failures.dart';
import 'package:contact_book/features/company/domain/entities/company_entity.dart';
import 'package:contact_book/features/company/domain/repositories/company_repository.dart';
import 'package:dartz/dartz.dart';

class GetCompanyInfoUseCase {
  CompanyRepository companyRepository;
  GetCompanyInfoUseCase({
    required this.companyRepository,
  });
  Future<Either<Failure, CompanyEntity>> call() {
    return companyRepository.getCompanyInfo();
  }
}
