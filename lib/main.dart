import 'package:contact_book/core/utils/hive_init.dart';
import 'package:contact_book/features/company/presentation/pages/company_profile_page.dart';
import 'package:contact_book/features/home/managers/network_cubit/network_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/utils/my_bloc_observer.dart';
import 'core/utils/theme_app.dart';
import 'core/widgets/show_custom_snackbar.dart';
import 'features/authentication/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'features/authentication/presentation/cubits/login_cubit/login_cubit.dart';
import 'features/authentication/presentation/cubits/logout_cubit/logout_cubit.dart';
import 'features/authentication/presentation/cubits/register_cubit/register_cubit.dart';
import 'features/authentication/presentation/pages/login_page.dart';
import 'features/authentication/presentation/pages/register_page.dart';
import 'features/company/presentation/bloc/company_bloc.dart';
import 'features/home/pages/home_page.dart';
import 'features/home/pages/splash_page.dart';

import 'container_injector.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hiveInit();
  await di.init();
  Bloc.observer = MyBlocObserver();
  runApp(const ContactBookApp());
}

class ContactBookApp extends StatelessWidget {
  const ContactBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AuthCubit>()),
        BlocProvider(create: (context) => di.sl<LoginCubit>()),
        BlocProvider(create: (context) => di.sl<RegisterCubit>()),
        BlocProvider(create: (context) => di.sl<LogoutCubit>()),
        BlocProvider(create: (context) => NetworkCubit()),
        BlocProvider(create: (context) => di.sl<CompanyBloc>())
      ],
      child: MaterialApp(
        scaffoldMessengerKey: SnackBarGlobal.key,
        debugShowCheckedModeBanner: false,
        theme: themeApp(),
        routes: {
          LoginPage.id: (context) => const LoginPage(),
          RegisterPage.id: (context) => const RegisterPage(),
          SplashPage.id: (context) => const SplashPage(),
          HomePage.id: (context) => const HomePage(),
          CompanyProfilePage.id: (context) => const CompanyProfilePage(),
        },
        initialRoute: SplashPage.id,
      ),
    );
  }
}

