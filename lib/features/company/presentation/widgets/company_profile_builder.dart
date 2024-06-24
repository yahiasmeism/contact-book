import '../bloc/company_bloc.dart';
import 'company_profile_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/snackbar_global.dart';

class CompanyProfileBuilder extends StatelessWidget {
  const CompanyProfileBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<CompanyBloc>().add(GetCompanyInfoEvent());
      },
      child: BlocConsumer<CompanyBloc, CompanyState>(
        listener: (context, state) {
          if (state is CompanyInfoUpdatedSuccess) {
            SnackBarGlobal.show(context, state.message, color: Colors.green);
          } else if (state is CompanyInfoFailure) {
            SnackBarGlobal.show(context, state.message, color: Colors.red);
          }
        },
        builder: (context, state) {
          if (state is CompanyInfoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const CompanyProfileBody();
          }
        },
      ),
    );
  }
}
