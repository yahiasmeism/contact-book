import 'package:bloc/bloc.dart';
import '../../../../../core/constants/messages.dart';
import '../../../domain/entities/login.dart';
import '../../../domain/use_cases/login_usecase.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginUseCase loginUseCase;
  LoginCubit({required this.loginUseCase}) : super(LoginInitial());

  void loginSubmit({required LoginEntity login}) async {
    emit(LoginLoading());
    final loginEither = await loginUseCase(login: login);

    loginEither.fold(
      (failure) => emit(LoginFailure(message: failure.message)),
      (success) =>
          emit(const LoginSuccess(message: MESSAGES.LOGIN_SUCCESSFULLY)),
    );
  }
}
