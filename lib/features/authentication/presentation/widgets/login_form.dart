import '../../../home/persintation/pages/home_page.dart';
import '../cubits/login_cubit/login_cubit.dart';

import '../../../../core/constants/styles.dart';
import '../pages/register_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../domain/entities/login.dart';

import '../../../../core/widgets/custom_email_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_outline_button.dart';
import '../../../../core/widgets/custom_password_form_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    double screenWidth = MediaQuery.of(context).size.width;
    bool isWideScreen = screenWidth > 500;
    return Center(
      child: SizedBox(
        width: isWideScreen ? (screenWidth * 0.7) : (screenWidth * 0.85),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) async {
            if (state is LoginSuccess) {
              Fluttertoast.showToast(msg: state.message);
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomePage.name,
                (route) => false,
              );
            } else if (state is LoginFailure) {
              Fluttertoast.showToast(msg: state.message);
            }
          },
          builder: (context, state) {
            return AbsorbPointer(
              absorbing: state is LoginLoading,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 68),
                    //
                    // 1) ===========> Email
                    CustomEmailFormField(
                      controller: emailController,
                    ),
                    const SizedBox(height: 35),
                    //
                    // 3) ===========> Password
                    CustomPasswordFormField(
                      controller: passwordController,
                    ),

                    const SizedBox(height: 20),

                    // 4) =================> Login Button
                    const SizedBox(height: 47.5),
                    CustomButton(
                      isLoading: state is LoginLoading,
                      child: const Text('Sign in'),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final login = LoginEntity(
                            email: emailController.text,
                            password: passwordController.text,
                          );

                          context.read<LoginCubit>().loginSubmit(login: login);
                        }
                      },
                    ),
                    const SizedBox(height: 25),
                    // 5) ==========> Text And Dividers
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Divider(
                          endIndent: 20,
                          thickness: 2,
                        )),
                        Text(
                          'Don\'t have account?',
                          style: STYLES.TEXT_STYLE_16,
                        ),
                        Expanded(
                            child: Divider(
                          indent: 20,
                          thickness: 2,
                        )),
                      ],
                    ),

                    // 6) ================> Register Button
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 160,
                      child: CustomOutlineButton(
                        child: const Text(
                          'Sign up',
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterPage.name);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
