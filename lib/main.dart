import 'package:contact_book/core/router/app_router.dart';
import 'package:contact_book/features/contacts/presentation/managers/contacts_bloc/contacts_bloc.dart';
import 'package:contact_book/features/contacts/presentation/managers/send_email_cubit/send_email_cubit.dart';
import 'package:contact_book/features/home/persintation/cubits/activities_cubit/activities_cubit.dart';

import 'core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/service_locator.dart' as di;
import 'core/utils/hive_init.dart';
import 'core/utils/my_bloc_observer.dart';
import 'core/utils/my_routes_observer.dart';
import 'core/widgets/snackbar_global.dart';
import 'features/authentication/presentation/cubits/authorization_cubit/authorization_cubit.dart';
import 'features/authentication/presentation/cubits/login_cubit/login_cubit.dart';
import 'features/authentication/presentation/cubits/logout_cubit/logout_cubit.dart';
import 'features/authentication/presentation/cubits/register_cubit/register_cubit.dart';
import 'features/company/presentation/bloc/company_bloc.dart';
import 'features/users/presentation/blocs/current_user_cubit/current_user_cubit.dart';
import 'features/users/presentation/blocs/users_bloc.dart';

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
        BlocProvider(create: (context) => di.sl<AuthorizedCubit>()),
        BlocProvider(create: (context) => di.sl<LoginCubit>()),
        BlocProvider(create: (context) => di.sl<RegisterCubit>()),
        BlocProvider(create: (context) => di.sl<LogoutCubit>()),
        BlocProvider(create: (context) => di.sl<CompanyBloc>()),
        BlocProvider(create: (context) => di.sl<UsersBloc>()),
        BlocProvider(create: (context) => di.sl<CurrentUserCubit>()),
        BlocProvider(create: (context) => di.sl<ContactsBloc>()),
        BlocProvider(create: (context) => di.sl<SendEmailCubit>()),
        BlocProvider(create: (context) => di.sl<ActivitiesCubit>()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        navigatorObservers: [routeObserver],
        scaffoldMessengerKey: SnackBarGlobal.key,
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        routes: AppRouter.routes,
        initialRoute: AppRouter.initRoute,
      ),
    );
  }
}
