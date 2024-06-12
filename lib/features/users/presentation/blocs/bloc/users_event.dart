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

class DeleteUsersEvent extends UsersEvent {
  final List<String> usersId;

  const DeleteUsersEvent({required this.usersId});
  @override
  List<Object> get props => [usersId];
}

class SearchUserEvent extends UsersEvent {
  final String searchKeyword;

  const SearchUserEvent({required this.searchKeyword});
  @override
  List<Object> get props => [searchKeyword];
}
