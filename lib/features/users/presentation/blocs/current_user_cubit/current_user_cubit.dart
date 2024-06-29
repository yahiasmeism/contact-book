import 'package:bloc/bloc.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/use_cases/get_current_user_use_case.dart';
import 'package:equatable/equatable.dart';

part 'current_user_state.dart';

class CurrentUserCubit extends Cubit<CurrentUserState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  CurrentUserCubit({required this.getCurrentUserUseCase})
      : super(CurrentUSerInitial());



  getCurrentUset() async {
    emit(CurrnetUserLoading());
    final either = await getCurrentUserUseCase.call();
    either.fold((failure) {}, (currentUser) {
     
      emit(CurrentUserLoaded(user: currentUser));
    });
  }
}
