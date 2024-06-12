import 'package:contact_book/core/widgets/main_app_bar.dart';
import 'package:contact_book/core/widgets/drawer/main_nav_drawer.dart';
import 'package:flutter/material.dart';
import '../widgets/company_profile_builder.dart';

class CompanyProfilePage extends StatelessWidget {
  const CompanyProfilePage({
    super.key,
  });
  static const id = 'Company Profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainNavDrawer(),
      appBar: mainAppBar(),
      body: const CompanyProfileBuilder(),
    );
  }
}
