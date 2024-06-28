import 'package:contact_book/core/network/api_client.dart';
import 'package:contact_book/features/contacts/data/data_sources/contacts_local_data_source.dart';
import 'package:contact_book/features/contacts/data/data_sources/contacts_remote_data_source.dart';
import 'package:contact_book/features/contacts/data/repositories_impl/contacts_repository_impl.dart';
import 'package:contact_book/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:contact_book/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:contact_book/features/contacts/presentation/bloc/send_email_cubit/send_email_cubit.dart';
import 'package:contact_book/features/home/data/date_sources/activities_local_data_source.dart';
import 'package:contact_book/features/home/data/date_sources/activities_remote_data_source.dart';
import 'package:contact_book/features/home/data/repository_impl/home_repository_impl.dart';
import 'package:contact_book/features/home/domin/use_case/get_activities_use_case.dart';
import 'package:contact_book/features/home/persintation/cubits/activities_cubit/activities_cubit.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../features/contacts/domain/use_cases/create_contact_use_case.dart';
import '../../features/contacts/domain/use_cases/delete_contacts_use_case.dart';
import '../../features/contacts/domain/use_cases/get_all_contacts_use_case.dart';
import '../../features/contacts/domain/use_cases/send_emai_use_case.dart';
import '../../features/contacts/domain/use_cases/toggle_favorite_use_case.dart';
import '../../features/contacts/domain/use_cases/update_contact_use_case.dart';
import '../../features/home/domin/repository/home_repository.dart';
import '../network/network_info.dart';
import '../../features/company/data/data_sources/company_local_data_source.dart';
import '../../features/company/data/data_sources/company_remote_data_source.dart';
import '../../features/company/data/repositories_impl/company_repository_impl.dart';
import '../../features/company/domain/repositories/company_repository.dart';
import '../../features/company/domain/use_cases/get_company_info_use_case.dart';
import '../../features/users/data/data_sources/users_local_data_source.dart';
import '../../features/users/data/data_sources/users_remote_data_source.dart';
import '../../features/users/data/repositories_impl/user_repository_impl.dart';
import '../../features/users/domain/repositories/user_repository.dart';
import '../../features/users/domain/use_cases/add_user_use_case.dart';
import '../../features/users/domain/use_cases/get_all_user_use_case.dart';
import '../../features/users/domain/use_cases/get_current_user_use_case.dart';
import '../../features/users/domain/use_cases/update_user_use_case.dart';
import '../../features/users/presentation/blocs/current_user_cubit/current_user_cubit.dart';
import '../../features/authentication/domain/use_cases/check_logged_in_use_case.dart';

import '../../features/authentication/data/data_sources/auth_local_data_source.dart';
import '../../features/authentication/data/data_sources/auth_remote_data_source.dart';
import '../../features/authentication/data/repositories_impl/auth_repository_impl.dart';
import '../../features/authentication/domain/repositories/auth_repository.dart';
import '../../features/authentication/domain/use_cases/login_usecase.dart';
import '../../features/authentication/domain/use_cases/logout_usecase.dart';
import '../../features/authentication/domain/use_cases/register_usecase.dart';
import '../../features/authentication/presentation/cubits/auth_cubit/auth_cubit.dart';
import '../../features/authentication/presentation/cubits/login_cubit/login_cubit.dart';
import '../../features/authentication/presentation/cubits/logout_cubit/logout_cubit.dart';
import '../../features/authentication/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/company/domain/use_cases/updata_company_info_user_case.dart';
import '../../features/company/presentation/bloc/company_bloc.dart';
import '../../features/users/domain/use_cases/delete_users_use_case.dart';
import '../../features/users/presentation/blocs/users_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //! Features
  //! Home feautere ==============================================
  // cubits & blocs
  sl.registerFactory(() => ActivitiesCubit(getActivitiesUseCase: sl()));
  // use cases
  sl.registerLazySingleton(() => GetActivitiesUseCase(homeRepository: sl()));
  // repositories
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(networkInfo: sl(), local: sl(), remote: sl()),
  );
  // datasources
  sl.registerLazySingleton<ActivitiesRemoteDataSource>(
    () => ActivitiesRemoteDataSourceImpl(
        apiClient: sl(), sharedPreferences: sl()),
  );
  sl.registerLazySingleton<ActivitiesLocalDataSource>(
    () => ActivitiesLocalDataSourceImpl(),
  );

  //! Contacts feautere ==============================================

  // cubits & blocs
  sl.registerFactory(
    () => ContactsBloc(
      createContactUseCase: sl(),
      deleteContactsUseCase: sl(),
      getAllContactsUseCase: sl(),
      toggleFavoriteUseCase: sl(),
      updateContactUseCase: sl(),
    ),
  );
  sl.registerFactory(() => SendEmailCubit(sendEmaiUseCase: sl()));

  // use cases
  sl.registerLazySingleton(
      () => CreateContactUseCase(contactsRepository: sl()));
  sl.registerLazySingleton(
      () => DeleteContactsUseCase(contactsRepository: sl()));
  sl.registerLazySingleton(
      () => GetAllContactsUseCase(contactsRepository: sl()));
  sl.registerLazySingleton(
      () => ToggleFavoriteUseCase(contactsRepository: sl()));
  sl.registerLazySingleton(
      () => UpdateContactUseCase(contactsRepository: sl()));
  sl.registerLazySingleton(() => SendEmaiUseCase(contactsRepository: sl()));

  // repositories
  sl.registerLazySingleton<ContactsRepository>(
    () => ContactsRepositoryImpl(networkInfo: sl(), local: sl(), remote: sl()),
  );

  // datasources
  sl.registerLazySingleton<ContactsRemoteDataSource>(
    () =>
        ContactsRemoteDataSourceImpl(apiClient: sl(), sharedPreferences: sl()),
  );
  sl.registerLazySingleton<ContactsLocalDataSource>(
    () => ContacstLocalDataSourceImpl(cacheManager: sl()),
  );

  //! Authentication feautere ==============================================

  // cubits && blocs

  sl.registerFactory(() => LoginCubit(loginUseCase: sl()));
  sl.registerFactory(() => RegisterCubit(registerUseCase: sl()));
  sl.registerFactory(() => LogoutCubit(logoutUseCase: sl()));
  sl.registerFactory(() => AuthCubit(checkIsLoggedInUseCase: sl()));

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => RegisterUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => CheckIsLoggedInUseCase(authRepository: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(local: sl(), remote: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceimpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiClient: sl()),
  );

  //! Company feautere ==========================================================
  // bloc
  sl.registerFactory(
    () => CompanyBloc(
        getCompanyInfoUseCase: sl(), updateCompanyInfoUseCase: sl()),
  );

  // use cases
  sl.registerLazySingleton(
      () => GetCompanyInfoUseCase(companyRepository: sl()));
  sl.registerLazySingleton(
      () => UpdateCompanyInfoUseCase(companyRepository: sl()));

  // repositories
  sl.registerLazySingleton<CompanyRepository>(
    () => CompanyRepositoryImpl(
      companyLocalDataSource: sl(),
      companyRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // data sources
  sl.registerLazySingleton<CompanyLocalDataSource>(
    () => CompanyLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<CompanyRemoteDataSource>(
    () => CompanyRemoteDataSourceImpl(apiClient: sl(), sharedPreferences: sl()),
  );

  //! Users Feature ===========================================
  // Bloc
  sl.registerFactory(() => UsersBloc(
        getCurrentUserUseCase: sl(),
        updateUserUseCase: sl(),
        getAllUserUseCase: sl(),
        deleteUserUseCase: sl(),
        addUserUseCase: sl(),
      ));
  sl.registerFactory(() => CurrentUserCubit(getCurrentUserUseCase: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetAllUserUseCase(userRepository: sl()));
  sl.registerLazySingleton(() => DeleteUsersUseCase(userRepository: sl()));
  sl.registerLazySingleton(() => AddUserUseCase(userRepository: sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(userRepository: sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(userRepository: sl()));

  // repositories
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        networkInfo: sl(),
        usersLocal: sl(),
        usersRemote: sl(),
      ));

  // data sources
  sl.registerLazySingleton<UsersLocalDataSource>(
      () => UsersLocalDataSourceImpl());
  sl.registerLazySingleton<UsersRemoteDataSource>(
      () => UsersRemoteDataSourceImpl(
            apiClient: sl(),
            sharedPreferences: sl(),
          ));
  //! External ===============================================================
  sl.registerLazySingleton(() => (Dio()));
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );

  //! Core =======================================================
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton<CacheManager>(() => DefaultCacheManager());
  sl.registerLazySingleton<ApiClient>(() => (ApiClientImpl(dio: sl())));
}
