import 'package:contact_book/core/constants/styles.dart';

import '../../../../core/widgets/footer_app.dart';
import '../widgets/registeration_form.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static const name = 'Register';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: const Center(
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        'Create Account',
                        style: STYLES.TEXT_STYLE_24,
                      ),
                    ),
                    RegistrationForm(),
                    Footer(),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
