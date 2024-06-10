import 'package:bloc/bloc.dart';
import 'package:contact_book/features/users/domain/entities/user_entity.dart';
import 'package:contact_book/features/users/domain/use_cases/get_all_user_use_case.dart';
import 'package:equatable/equatable.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetAllUserUseCase getAllUserUseCase;
  List<UserEntity> users = [];
  UsersBloc({required this.getAllUserUseCase}) : super(UsersInitial()) {
    // get all users
    on<GetAllUsersEvent>((event, emit) async {
      emit(UsersLoading());
      final either = await getAllUserUseCase.call();
      either.fold((failure) => emit(UsersFailure(message: failure.message)),
          (users) {
        this.users.addAll(users);
        emit(UsersLoaded());
      });
    });

    // get current user
    // on<GetCurrentUserEvent>((event, emit) {
    //   emit(UsersLoading());

    // });
  }
}
