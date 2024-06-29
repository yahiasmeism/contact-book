import 'package:contact_book/core/constants/constant.dart';
import 'package:contact_book/features/contacts/presentation/managers/contacts_bloc/contacts_bloc.dart';
import 'package:contact_book/features/home/persintation/cubits/activities_cubit/activities_cubit.dart';
import 'package:hive/hive.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../../../company/presentation/bloc/company_bloc.dart';
import '../../../users/presentation/blocs/current_user_cubit/current_user_cubit.dart';
import '../../../users/presentation/blocs/users_bloc.dart';
import '../widgets/home_body.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const name = 'Home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<CompanyBloc>().add(GetCompanyInfoEvent());
    context.read<UsersBloc>().add(GetAllUsersEvent());
    context.read<CurrentUserCubit>().getCurrentUset();
    context.read<ContactsBloc>().add(GetAllContactsEvent());
    context.read<ActivitiesCubit>().getActivities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(body: HomeBody());
  }

  @override
  void dispose() {
    Hive.box(APP_BOX).compact();
    super.dispose();
  }
}
