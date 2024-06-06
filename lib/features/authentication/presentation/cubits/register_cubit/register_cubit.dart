// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:contact_book/features/authentication/domain/entities/register.dart';
import 'package:contact_book/features/authentication/domain/use_cases/register_usecase.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterUseCase registerUseCase;
  RegisterCubit({required this.registerUseCase}) : super(RegisterInitial());

  void registerSubmit({required RegisterEntity registerEntity}) async {
    emit(RegisterLoading());
    final registerEither = await registerUseCase(register: registerEntity);

    registerEither.fold(
      (failure) => emit(RegisterFailure(message: failure.message)),
      (success) => emit(RegisterSuccess()),
    );
  }
}
