import 'package:bloc/bloc.dart';

import '../../../domain/use_cases/check_logged_in_use_case.dart';

enum AuthState { init, authenticated, unauthenticated }

class AuthCubit extends Cubit<AuthState> {
  CheckIsLoggedInUseCase checkIsLoggedInUseCase;
  AuthCubit({required this.checkIsLoggedInUseCase}) : super(AuthState.init);

  void checkIsLoggedIn() async {
    final isLoggedinResult = await checkIsLoggedInUseCase();
    isLoggedinResult.fold(
      (fail) => emit(AuthState.unauthenticated),
      (success) => emit(AuthState.authenticated),
    );
  }
}
