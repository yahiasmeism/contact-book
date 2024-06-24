import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'container_injector.dart' as di;
import 'core/utils/hive_init.dart';
import 'core/utils/my_bloc_observer.dart';
import 'core/utils/my_routes_observer.dart';
import 'core/utils/theme_app.dart';
import 'core/widgets/snackbar_global.dart';
import 'features/authentication/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'features/authentication/presentation/cubits/login_cubit/login_cubit.dart';
import 'features/authentication/presentation/cubits/logout_cubit/logout_cubit.dart';
import 'features/authentication/presentation/cubits/register_cubit/register_cubit.dart';
import 'features/authentication/presentation/pages/login_page.dart';
import 'features/authentication/presentation/pages/register_page.dart';
import 'features/company/presentation/bloc/company_bloc.dart';
import 'features/company/presentation/pages/company_profile_page.dart';
import 'features/home/managers/network_cubit/network_cubit.dart';
import 'features/home/pages/home_page.dart';
import 'features/home/pages/splash_page.dart';
import 'features/users/presentation/blocs/current_user_cubit/current_user_cubit.dart';
import 'features/users/presentation/blocs/users_bloc.dart';
import 'features/users/presentation/pages/user_details_page.dart';
import 'features/users/presentation/pages/user_invite_page.dart';
import 'features/users/presentation/pages/users_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hiveInit();
  await di.init();
  Bloc.observer = MyBlocObserver();
  runApp(const ContactBookApp());
}

class ContactBookApp extends StatelessWidget {
  const ContactBookApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final AppNavigatorObserver routeObserver = AppNavigatorObserver();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AuthCubit>()),
        BlocProvider(create: (context) => di.sl<LoginCubit>()),
        BlocProvider(create: (context) => di.sl<RegisterCubit>()),
        BlocProvider(create: (context) => di.sl<LogoutCubit>()),
        BlocProvider(create: (context) => NetworkCubit()),
        BlocProvider(create: (context) => di.sl<CompanyBloc>()),
        BlocProvider(create: (context) => di.sl<UsersBloc>()),
        BlocProvider(create: (context) => di.sl<CurrentUserCubit>()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        navigatorObservers: [routeObserver],
        scaffoldMessengerKey: SnackBarGlobal.key,
        debugShowCheckedModeBanner: false,
        theme: themeApp(),
        routes: {
          LoginPage.name: (context) => const LoginPage(),
          RegisterPage.name: (context) => const RegisterPage(),
          SplashPage.name: (context) => const SplashPage(),
          HomePage.name: (context) => const HomePage(),
          CompanyProfilePage.name: (context) => const CompanyProfilePage(),
          UsersPage.name: (context) => const UsersPage(),
          UserInvitePage.name: (context) => const UserInvitePage(),
          UserDetailsPage.name: (context) => const UserDetailsPage(),
        },
        initialRoute: SplashPage.name,
      ),
    );
  }
}
