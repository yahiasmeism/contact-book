import 'package:contact_book/core/constants/styles.dart';
import 'package:contact_book/core/widgets/custom_divider.dart';
import 'package:contact_book/features/home/persintation/cubits/activities_cubit/activities_cubit.dart';
import 'package:contact_book/features/home/persintation/widgets/activity_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LatestActivities extends StatelessWidget {
  const LatestActivities({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivitiesCubit, ActivitiesState>(
      builder: (context, state) {
        final latestActivity = context.read<ActivitiesCubit>().latestActivity;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    'Latest activities',
                    style: STYLES.TEXT_STYLE_24,
                  ),
                ),
              ),
              const CustomDivider(),
              const SizedBox(height: 32),
              ListView.builder(
                itemCount: latestActivity.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ActivityTile(activityEntity: latestActivity[index]);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
