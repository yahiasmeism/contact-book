import '../../../../core/error/failures.dart';
import '../entities/company_entity.dart';
import '../repositories/company_repository.dart';
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
