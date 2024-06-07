import 'package:dio/dio.dart';

class EmptyChacheException implements Exception {
  final String message;

  EmptyChacheException(this.message);
}
class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}

class ServerException implements Exception {
  final String message;
  const ServerException({required this.message});

  factory ServerException.fromDioException(DioException dioException) {
    final String message;

    switch (dioException.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout";
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection";
        break;
      case DioExceptionType.badResponse:
        message = "Session has expired , please login again";
        break;
      case DioExceptionType.connectionError:
        message = "Check internet connection";
        break;
      case DioExceptionType.badCertificate:
        message = "Bad certificate error";
        break;
      case DioExceptionType.unknown:
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
    return ServerException(message: message);
  }
}

class NetworkException implements Exception {
  final String message;
  NetworkException({required this.message});
}
