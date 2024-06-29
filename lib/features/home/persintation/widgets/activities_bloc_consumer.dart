import 'package:contact_book/core/widgets/snackbar_global.dart';
import 'package:contact_book/features/home/persintation/cubits/activities_cubit/activities_cubit.dart';
import 'package:contact_book/features/home/persintation/widgets/activities_list_view_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'activities_fading_loading_indecator.dart';

class ActivitiesBlocConsumer extends StatelessWidget {
  const ActivitiesBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivitiesCubit, ActivitiesState>(
      listener: (context, state) {
        if (state is ActivitiesFailure) {
          SnackBarGlobal.show(context, state.message, color: Colors.red);
        }
      },
      builder: (context, state) {
        if (state is ActivitiesLoading) {
          return const ActivitiesFadingLoadingIndecator(itemCount: 7);
        } else if (state is ActivitiesLoaded) {
          final activities = context.read<ActivitiesCubit>().activities;
          return ActivitiesListViewPagination(activities: activities);
        } else {
          return const Center();
        }
      },
    );
  }
}
