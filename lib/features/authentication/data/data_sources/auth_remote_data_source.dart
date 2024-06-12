import 'package:dio/dio.dart';

import '../../../../core/constants/api.dart';
import '../../../../core/constants/messages.dart';
import '../../../../core/error/exceptions.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> login(LoginModel login);
  Future<void> register(RegisterModel register);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  Dio dio;
  AuthRemoteDataSourceImpl({
    required this.dio,
  }) {
    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 3),
      sendTimeout: const Duration(seconds: 3),
      receiveTimeout: const Duration(seconds: 3),
    );
  }

  @override
  Future<String> login(LoginModel login) async {
    try {
      Response response = await dio.post(
        API.LOGIN,
        data: login.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return response.data['token'];
    } on DioException catch (e) {
      throw ServerException(message: _mapLoginDioExceptionToMessage(e));
    }
  }

  @override
  Future<void> register(RegisterModel register) async {
    try {
      await dio.post(
        API.REGISTER,
        data: register.toJson(),
      );
    } on DioException catch (e) {
      throw ServerException(message: _mapRegisterDioExceptionToMessage(e));
    }
  }

  //=======================
  String _mapLoginDioExceptionToMessage(DioException e) {
    if (e.response?.statusCode == 401) {
      return MESSAGES.INCORRECT_EMAIL_OR_PASSWORD;
    } else if (e.type == DioExceptionType.connectionError) {
      return MESSAGES.CHECK_NETWORK;
    } else {
      return MESSAGES.UNEXPECTED_ERROR;
    }
  }
}

String _mapRegisterDioExceptionToMessage(DioException e) {
  String errorMessage;
  if (e.response?.statusCode == 403) {
    errorMessage = MESSAGES.EMIAL_ALREADY_EXIST;
  } else if (e.response?.statusCode == 400) {
    // response errors
    final Map<String, dynamic> errors = e.response?.data['errors'];
    // frist error
    final MapEntry<String, dynamic> firstError = errors.entries.first;
    // message in first error
    errorMessage = (firstError.value as List).first;
  } else if (e.type == DioExceptionType.connectionError) {
    errorMessage = MESSAGES.CHECK_NETWORK;
  } else {
    errorMessage = MESSAGES.UNEXPECTED_ERROR;
  }
  return errorMessage;
}
