import 'package:dio/dio.dart';
import '../../constants/messages.dart';

class AppInterceptor extends Interceptor {
  final String? token;

  AppInterceptor(this.token);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final String message;
    switch (err.type) {
      case DioExceptionType.badResponse:
        if (err.response?.statusCode == 401) {
          message = MESSAGES.SESSION_HAS_EXPIRED;
        } else if (err.response?.statusCode == 404) {
          message = MESSAGES.NOT_FOUND;
        } else if (err.response?.statusCode == 403) {
          message = MESSAGES.FORBIDDEN;
        } else {
          message = MESSAGES.INVALID_REQUEST;
        }
        break;
      case DioExceptionType.cancel:
        message = MESSAGES.REQUSET_HAS_CANCEL;
        break;
      case DioExceptionType.connectionTimeout:
        message = MESSAGES.CONNECTION_TIMEOUT;
        break;
      case DioExceptionType.sendTimeout:
        message = MESSAGES.SEND_TIMEOUT;
        break;
      case DioExceptionType.receiveTimeout:
        message = MESSAGES.RECIVE_TIMEOUT;
        break;

      case DioExceptionType.connectionError:
        message = MESSAGES.CONNECTION_TIMEOUT;
        break;
      case DioExceptionType.badCertificate:
        message = MESSAGES.BAD_CERTIFICATE;
        break;
      default:
        message = MESSAGES.UNEXPECTED_ERROR;
    }
    final newError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: err.error,
      message: message,
    );
    super.onError(newError, handler);
  }
}
