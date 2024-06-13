import 'package:bloc/bloc.dart';
import 'package:contact_book/core/constants/messages.dart';
import 'package:contact_book/features/users/domain/entities/user_entity.dart';
import 'package:contact_book/features/users/domain/use_cases/add_user_use_case.dart';
import 'package:contact_book/features/users/domain/use_cases/get_all_user_use_case.dart';
import 'package:equatable/equatable.dart';

import '../../domain/use_cases/delete_users_use_case.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetAllUserUseCase getAllUserUseCase;
  final DeleteUsersUseCase deleteUserUseCase;
  final AddUserUseCase addUserUseCase;
  List<UserEntity> usersSelected = [];
  List<UserEntity> users = [];
  UsersBloc({
    required this.addUserUseCase,
    required this.getAllUserUseCase,
    required this.deleteUserUseCase,
  }) : super(UsersInitial()) {
    // get all users
    on<GetAllUsersEvent>((event, emit) async {
      emit(UsersLoading());
      final either = await getAllUserUseCase.call();
      either.fold((failure) => emit(UsersFailure(message: failure.message)),
          (users) {
        this.users = users;
        emit(UsersLoaded());
      });
    });
    // search user
    on<FilterUserEvent>((event, emit) {
      List<UserEntity> usersFilter = users.where(
        (user) {
          return ("${user.firstName} ${user.lastName}")
                  .startsWith(event.searchKeyword.trim()) |
              user.lastName.startsWith(event.searchKeyword.trim()) |
              user.email.contains(event.searchKeyword.trim()) |
              user.phoneNumber.contains(event.searchKeyword.trim());
        },
      ).toList();
      emit(FilterUsersState(usersFilter: usersFilter));
    });
    // undo search
    on<UndoFilterUsersEvent>((event, emit) {
      emit(UsersLoaded());
    });

    // delete user
    on<DeleteUsersEvent>((event, emit) async {
      emit(UsersLoading());
      final either = await deleteUserUseCase(usersId: event.usersId);
      either.fold((failure) => emit(UsersFailure(message: failure.message)),
          (success) {
        users.removeWhere((user) => event.usersId.contains(user.id));
        emit(UsersLoaded());
        emit(const UserOperationSuccess(message: MESSAGES.DELETE_SUCCESS));
      });
    });

    // add new user
    on<AddUserEvent>((event, emit) async {
      emit(UsersLoading());
      final result = await addUserUseCase(userEntity: event.user);
      result.fold(
        (fialure) => emit(UsersFailure(message: fialure.message)),
        (userAdded) {
          users.add(userAdded);
          emit(UsersLoaded());
          emit(
            const UserOperationSuccess(message: MESSAGES.INVITED_SUCCESSfFULY),
          );
        },
      );
    });
  }
}
