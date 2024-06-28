import 'package:bloc/bloc.dart';
import '../../../../core/constants/messages.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/use_cases/add_user_use_case.dart';
import '../../domain/use_cases/get_all_user_use_case.dart';
import '../../domain/use_cases/get_current_user_use_case.dart';
import '../../domain/use_cases/update_user_use_case.dart';
import 'package:equatable/equatable.dart';

import '../../domain/use_cases/delete_users_use_case.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetAllUserUseCase getAllUserUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final DeleteUsersUseCase deleteUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final AddUserUseCase addUserUseCase;
  List<UserEntity> usersSelected = [];
  List<UserEntity> users = [];
  UsersBloc({
    required this.getCurrentUserUseCase,
    required this.updateUserUseCase,
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
        usersSelected.clear();
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
      emit(OnFilterUsersState(usersFilter: usersFilter));
    });
    // undo search
    on<UndoFilterUsersEvent>((event, emit) {
      emit(UsersLoaded());
    });

    // delete user
    on<DeleteUsersEvent>((event, emit) async {
      emit(UsersLoading());
      final either = await deleteUserUseCase(users: event.users);
      either.fold((failure) => emit(UsersFailure(message: failure.message)),
          (success) {
        users.removeWhere((user) => event.users.contains(user));
        emit(const UserOperationSuccess(message: MESSAGES.DELETE_SUCCESS));
      });
      usersSelected.clear();
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

    ///update user event
    on<UpdateUserEvent>((event, emit) async {
      final oldUserIndex = users.indexWhere((u) => event.user.id == u.id);
      emit(UsersLoading());
      final either = await updateUserUseCase.call(userEntity: event.user);
      either.fold((failure) {
        emit(UsersFailure(message: failure.message));
      }, (userUpdated) {
        userUpdated.id = event.user.id;
        users[oldUserIndex] = userUpdated;
        emit(const UserOperationSuccess(message: MESSAGES.UPDATED_SUCCESS));
      });
    });
  }
}
