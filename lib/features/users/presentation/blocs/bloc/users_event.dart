part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class GetAllUsersEvent extends UsersEvent {}

class GetCurrentUserEvent extends UsersEvent {}

class GetUserEvent extends UsersEvent {
  final String userId;

  const GetUserEvent({required this.userId});
  @override
  List<Object> get props => [userId];
}

class UpdateUserEvent extends UsersEvent {
  final UserEntity userEntity;

  const UpdateUserEvent({required this.userEntity});
  @override
  List<Object> get props => [userEntity];
}

class DeleteUserEvent extends UsersEvent {
  final String userId;

  const DeleteUserEvent({required this.userId});
  @override
  List<Object> get props => [userId];
}
