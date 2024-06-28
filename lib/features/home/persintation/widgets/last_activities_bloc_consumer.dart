import 'package:contact_book/features/home/persintation/cubits/activities_cubit/activities_cubit.dart';
import 'package:contact_book/features/home/persintation/widgets/activities_fading_loading_indecator.dart';
import 'package:contact_book/features/home/persintation/widgets/activities_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LastActivitiesBlocConsumer extends StatelessWidget {
  const LastActivitiesBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivitiesCubit, ActivitiesState>(
      builder: (context, state) {
        //
        if (state is ActivitiesLoading) {
          //
          return const ActivitiesFadingLoadingIndecator(
            itemCount: 5,
          );
          //
        } else if (state is ActivitiesLoaded) {
          //
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: ActivitiesListView(
              activities: context.read<ActivitiesCubit>().latestActivity,
            ),
          );
          //
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
