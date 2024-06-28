part of 'activities_cubit.dart';

sealed class ActivitiesState extends Equatable {
  const ActivitiesState();

  @override
  List<Object> get props => [];
}

final class ActivitiesInitial extends ActivitiesState {}

final class ActivitiesLoading extends ActivitiesState {}

final class ActivitiesLoaded extends ActivitiesState {}

final class ActivitieFailure extends ActivitiesState {
  final String message;

  const ActivitieFailure({required this.message});
}
