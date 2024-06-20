part of 'current_user_cubit.dart';

sealed class CurrentUserState extends Equatable {
  const CurrentUserState();

  @override
  List<Object> get props => [];
}

final class CurrentUSerInitial extends CurrentUserState {}

final class CurrnetUserLoading extends CurrentUserState {}

final class CurrnetUserFailure extends CurrentUserState {
  final String message;

  const CurrnetUserFailure({required this.message});
}

final class CurrnetUserLoaded extends CurrentUserState {
  final UserEntity user;

  const CurrnetUserLoaded({required this.user});
}
