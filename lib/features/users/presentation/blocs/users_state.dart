part of 'users_bloc.dart';

sealed class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

final class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {}

class UsersFailure extends UsersState {
  final String message;

  const UsersFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class UserOperationSuccess extends UsersState {
  final String message;

  const UserOperationSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class FilterUsersState extends UsersState {
  final List<UserEntity> usersFilter;

  const FilterUsersState({required this.usersFilter});

  @override
  List<Object> get props => [usersFilter];
}
