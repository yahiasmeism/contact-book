import '../../../../core/constants/assets.dart';
import '../../../authentication/presentation/cubits/authorization_cubit/authorization_cubit.dart';
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

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late Animation _animation;
  late AnimationController _controller;

  void initAnimation() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween(begin: -0.1, end: 0.1).animate(_controller);

    _controller.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void initState() {
    initAnimation();

    // weating 1 secound before check
    Future.delayed(const Duration(milliseconds: 2000), () {
      // Check if he is logged in or not by AuthenticationStatusChanged
      context.read<AuthorizedCubit>().checkIsLoggedIn();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthorizedCubit, AuthorizedState>(
      listener: (context, state) {
        if (state == AuthorizedState.authorized) {
          Navigator.pushReplacementNamed(
            context,
            HomePage.name,
          );
        } else if (state == AuthorizedState.unauthorized) {
          Navigator.pushReplacementNamed(
            context,
            LoginPage.name,
          );
        }
      },
      child: Scaffold(
        body: Transform.rotate(
          angle: _animation.value,
          child: Center(
            child: SvgPicture.asset(ASSETS.LOGO),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
