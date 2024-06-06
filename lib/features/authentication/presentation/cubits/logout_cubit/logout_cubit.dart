import 'package:bloc/bloc.dart';

import '../../../domain/use_cases/logout_usecase.dart';

enum LogoutState { init, loading, done }

class LogoutCubit extends Cubit<LogoutState> {
  LogoutUseCase logoutUseCase;
  LogoutCubit({required this.logoutUseCase}) : super(LogoutState.init);
  void logout() async {
    emit(LogoutState.loading);
    await logoutUseCase();
    emit(LogoutState.done);
  }
}
