import 'package:bloc/bloc.dart';

import '../../../domain/use_cases/check_logged_in_use_case.dart';

enum AuthorizedState { init, authorized, unauthorized }

class AuthorizedCubit extends Cubit<AuthorizedState> {
  CheckIsLoggedInUseCase checkIsLoggedInUseCase;
  AuthorizedCubit({required this.checkIsLoggedInUseCase})
      : super(AuthorizedState.init);

  void checkIsLoggedIn() async {
    final isLoggedinResult = await checkIsLoggedInUseCase();
    isLoggedinResult.fold(
      (fail) => emit(AuthorizedState.unauthorized),
      (success) => emit(AuthorizedState.authorized),
    );
  }
}
