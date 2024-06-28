import 'package:bloc/bloc.dart';
import 'package:contact_book/features/home/domin/use_case/get_activities_use_case.dart';
import 'package:equatable/equatable.dart';

import '../../../domin/entities/activity_entity.dart';

part 'activities_state.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  final GetActivitiesUseCase getActivitiesUseCase;
  ActivitiesCubit({required this.getActivitiesUseCase})
      : super(ActivitiesInitial());
  List<ActivityEntity> activities = [];

  getActivities() async {
    emit(ActivitiesLoading());
    final either = await getActivitiesUseCase();
    either.fold((failure) => emit(ActivitiesFailure(message: failure.message)),
        (activities) {
      this.activities = activities;
      emit(ActivitiesLoaded());
    });
  }

  List<ActivityEntity> get latestActivity {
    int countLastItem = 5;
    if (activities.length < 5) {
      countLastItem = activities.length;
    }

    return activities.getRange(0, countLastItem).toList();
  }
}
