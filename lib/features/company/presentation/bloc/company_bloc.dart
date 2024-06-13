import 'package:bloc/bloc.dart';
import 'package:contact_book/core/constants/messages.dart';
import 'package:equatable/equatable.dart';

import 'package:contact_book/features/company/domain/entities/company_entity.dart';
import 'package:contact_book/features/company/domain/use_cases/get_company_info_use_case.dart';
import 'package:contact_book/features/company/domain/use_cases/updata_company_info_user_case.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final GetCompanyInfoUseCase getCompanyInfoUseCase;
  final UpdateCompanyInfoUseCase updateCompanyInfoUseCase;
  CompanyEntity? company;
  CompanyBloc({
    required this.getCompanyInfoUseCase,
    required this.updateCompanyInfoUseCase,
  }) : super(CompanyInitial()) {
    // get company info
    on<GetCompanyInfoEvent>((event, emit) async {
      emit(CompanyInfoLoading());
      final result = await getCompanyInfoUseCase();
      result
          .fold((failure) => emit(CompanyInfoFailure(message: failure.message)),
              (companyEntity) {
                
        company = companyEntity;
        emit(CompanyInfoLoaded());
      });
    });

    // update company
    on<UpdateCompanyInfoEvent>((event, emit) async {
      emit(CompanyInfoLoading());
      final result = await updateCompanyInfoUseCase(event.companyEntity);
      result
          .fold((failure) => emit(CompanyInfoFailure(message: failure.message)),
              (updatedCompanyEntity) {
        company = updatedCompanyEntity;
        emit(const CompanyInfoUpdatedSuccess());
      });
    });
  }
}
