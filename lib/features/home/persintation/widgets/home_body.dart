import 'package:contact_book/core/widgets/footer_app.dart';
import 'package:contact_book/features/home/persintation/cubits/activities_cubit/activities_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/styles.dart';
import 'latest_activities.dart';
import 'statistics_items.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ActivitiesCubit>().getActivities();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  children: [
                    _buildHeader(),
                    const StatisticsItems(),
                    const SizedBox(height: 32),
                    const LatestActivities(),
                    const SizedBox(height: 32),
                    const Footer()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Statistical Dashboard',
                style: STYLES.TEXT_STYLE_20,
              ),
            ],
          ),
          Divider(
            height: 10,
            thickness: 1,
            color: Color(0xff868686),
          ),
        ],
      ),
    );
  }
}
