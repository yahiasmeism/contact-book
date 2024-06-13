import 'package:contact_book/core/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import '../widgets/company_profile_builder.dart';

class CompanyProfilePage extends StatelessWidget {
  const CompanyProfilePage({
    super.key,
  });
  static const name = 'Company Profile';

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: CompanyProfileBuilder(),
    );
  }
}
