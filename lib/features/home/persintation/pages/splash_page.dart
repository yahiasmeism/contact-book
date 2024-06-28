import '../../../../core/constants/assets.dart';
import '../../../authentication/presentation/cubits/auth_cubit/auth_cubit.dart';
import '../../../authentication/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static const name = 'SplashPage';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // weating 1 secound before check
    Future.delayed(const Duration(milliseconds: 1500), () {
      // Check if he is logged in or not by AuthenticationStatusChanged
      context.read<AuthCubit>().checkIsLoggedIn();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state == AuthState.authenticated) {
          Navigator.pushReplacementNamed(
            context,
            HomePage.name,
          );
        } else if (state == AuthState.unauthenticated) {
          Navigator.pushReplacementNamed(
            context,
            LoginPage.name,
          );
        }
      },
      child: Scaffold(
        body: Center(child: SvgPicture.asset(ASSETS.LOGO)),
      ),
    );
  }
}
