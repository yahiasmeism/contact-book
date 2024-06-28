part of 'activities_cubit.dart';

sealed class ActivitiesState extends Equatable {
  const ActivitiesState();

  @override
  List<Object> get props => [];
}

final class ActivitiesInitial extends ActivitiesState {}

final class ActivitiesLoading extends ActivitiesState {}

final class ActivitiesLoaded extends ActivitiesState {}

final class ActivitiesFailure extends ActivitiesState {
  final String message;

  const ActivitiesFailure({required this.message});
}
