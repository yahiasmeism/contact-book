part of 'company_bloc.dart';

sealed class CompanyEvent extends Equatable {
  const CompanyEvent();

  @override
  List<Object> get props => [];
}

class GetCompanyInfoEvent extends CompanyEvent {}

class UpdateCompanyInfoEvent extends CompanyEvent {
  final CompanyEntity companyEntity;

  const UpdateCompanyInfoEvent({required this.companyEntity});
}
