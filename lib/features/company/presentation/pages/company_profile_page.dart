import 'package:contact_book/core/widgets/main_app_bar.dart';
import 'package:contact_book/core/widgets/drawer/main_nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/show_custom_snackbar.dart';
import '../bloc/company_bloc.dart';
import '../widgets/company_profile_body.dart';

class CompanyProfilePage extends StatelessWidget {
  const CompanyProfilePage({
    super.key,
  });
  static const id = 'CompanyProfilePage';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyBloc, CompanyState>(
      listener: (context, state) {
        if (state is CompanyInfoUpdatedSuccess) {
          SnackBarGlobal.show(context, state.message, color: Colors.green);
        } else if (state is CompanyInfoFailure) {
          SnackBarGlobal.show(context, state.message, color: Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          drawer: const MainNavDrawer(),
          appBar: mainAppBar(),
          body: state is CompanyInfoLoading
              ? const Center(child: CircularProgressIndicator())
              : const CompanyProfileBody(),
        );
      },
    );
  }
}
