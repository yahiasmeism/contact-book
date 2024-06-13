import 'package:contact_book/core/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/widgets/footer_app.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const name = 'login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Footer(),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          children: [
            SvgPicture.asset(ASSETS.LOGO),
            const LoginForm(),
          ],
        )),
      ),
    );
  }
}
