part of 'company_bloc.dart';

sealed class CompanyState extends Equatable {
  const CompanyState();

  @override
  List<Object> get props => [];
}

final class CompanyInitial extends CompanyState {}

final class CompanyInfoLoading extends CompanyState {}

final class CompanyInfoLoaded extends CompanyState {}

final class CompanyInfoFailure extends CompanyState {
  final String message;

  const CompanyInfoFailure({required this.message});
}

final class CompanyInfoUpdatedSuccess extends CompanyState {
  final String message = MESSAGES.UPDATED_SUCCESS;

  const CompanyInfoUpdatedSuccess();
}
