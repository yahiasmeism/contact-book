import 'package:contact_book/core/widgets/snackbar_global.dart';
import 'package:contact_book/features/home/managers/network_cubit/network_cubit.dart';
import 'package:contact_book/features/home/widgets/home_body.dart';
import 'package:contact_book/features/users/presentation/blocs/users_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/app_scaffold.dart';
import '../../company/presentation/bloc/company_bloc.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkCubit, NetworkState>(
      listenWhen: (previous, current) {
        return !(previous == NetworkState.init &&
            current == NetworkState.online);
      },
      listener: (context, state) {
        if (state == NetworkState.offline) {
          SnackBarGlobal.show(
            context,
            'No Internet',
            color: Colors.red,
            icon: Icons.wifi_off,
          );
        } else if (state == NetworkState.online) {
          SnackBarGlobal.show(
            context,
            'Connected',
            color: Colors.green,
            icon: Icons.wifi,
          );
        }
      },
      child: const AppScaffold(body: HomeBody()),
    );
  }
}
