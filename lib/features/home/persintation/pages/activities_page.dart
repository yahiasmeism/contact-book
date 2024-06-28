import 'package:contact_book/core/widgets/app_scaffold.dart';
import 'package:contact_book/core/widgets/bread_crumb.dart';
import 'package:contact_book/features/home/persintation/cubits/activities_cubit/activities_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/activities_bloc_consumer.dart';

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});
  static const name = 'Activities';
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ActivitiesCubit>().getActivities();
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  child: Column(
                    children: [
                      BreadCrumbNavigator(),
                      ActivitiesBlocConsumer(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
