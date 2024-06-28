import 'package:dio/dio.dart';

import '../error/exceptions.dart';
import 'interceptor/app_interceptor.dart';
import 'interceptor/auth_interceptor.dart';

abstract class ApiClient<Response> {
  Future<Response> get(
    String path, {
    Map<String, dynamic>? query,
    String? token,
  });

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
  });

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
  });

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
  });

  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
  });
}

class ApiClientImpl extends ApiClient<Response> {
  final Dio dio;
  ApiClientImpl({required this.dio}) {
    dio.options = BaseOptions(
        connectTimeout: const Duration(seconds: 5),
        sendTimeout: const Duration(seconds: 3));
  }
  @override
  Future<Response> get(String path,
      {Map<String, dynamic>? query, String? token}) async {
    try {
      _addInterceptors(token);
      return await dio.get(
        path,
        queryParameters: query,
      );
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? '');
    }
  }

  @override
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    try {
      _addInterceptors(token);
      return await dio.post(
        path,
        queryParameters: query,
        data: data,
      );
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? '');
    }
  }

  @override
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    try {
      _addInterceptors(token);
      return await dio.put(
        path,
        queryParameters: query,
        data: data,
      );
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? '');
    }
  }

  @override
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    try {
      _addInterceptors(token);
      return await dio.delete(
        path,
        queryParameters: query,
        data: data,
      );
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? '');
    }
  }

  @override
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    try {
      _addInterceptors(token);
      return await dio.patch(
        path,
        queryParameters: query,
        data: data,
      );
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? '');
    }
  }

  _addInterceptors(String? token) {
    if (token == null) {
      dio.interceptors.add(AuthInterceptor());
    } else {
      dio.interceptors.add(AppInterceptor(token));
    }
  }
}
