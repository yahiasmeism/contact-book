import '../../../../core/error/failures.dart';
import '../entities/company_entity.dart';
import '../repositories/company_repository.dart';
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
