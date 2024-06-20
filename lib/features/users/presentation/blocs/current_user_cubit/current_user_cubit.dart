import 'package:bloc/bloc.dart';
import 'package:contact_book/features/users/domain/entities/user_entity.dart';
import 'package:contact_book/features/users/domain/use_cases/get_current_user_use_case.dart';
import 'package:equatable/equatable.dart';

part 'current_user_state.dart';

class CurrentUserCubit extends Cubit<CurrentUserState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  CurrentUserCubit({required this.getCurrentUserUseCase})
      : super(CurrentUSerInitial());

  getCurrentUset() async {
    emit(CurrnetUserLoading());
    final either = await getCurrentUserUseCase.call();
    either.fold((failure) {
      return emit(CurrnetUserFailure(message: failure.message));
    }, (currentUser) {
      return emit(CurrnetUserLoaded(user: currentUser));
    });
  }
}
