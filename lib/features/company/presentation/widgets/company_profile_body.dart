import '../../../../core/constants/styles.dart';
import 'company_profile_form.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/footer_app.dart';
import '../../../../core/widgets/bread_crumb.dart';

class CompanyProfileBody extends StatelessWidget {
  const CompanyProfileBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const BreadCrumbNavigator(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: Colors.white,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'My Profile',
                      style: STYLES.TEXT_STYLE_18,
                    ),
                  ),
                  SizedBox(height: 16),
                  CompanyProfileForm(),
                ],
              ),
            ),
            const Footer()
          ],
        ),
      ),
    );
  }
}
