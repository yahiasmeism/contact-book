import 'package:contact_book/core/constants/messages.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage;
    if (err.response != null) {
      switch (err.response?.statusCode) {
        case 400:
          errorMessage = MESSAGES.BAD_REQUEST;
          break;
        case 401:
          errorMessage = MESSAGES.INCORRECT_EMAIL_OR_PASSWORD;
          break;
        case 403:
          errorMessage = MESSAGES.EMAIL_ALREADY_EXIST;
          break;
        case 500:
          errorMessage = MESSAGES.SERVER_ERROR;
          break;
        default:
          errorMessage = MESSAGES.UNEXPECTED_ERROR;
      }
    } else {
      if (err.type == DioExceptionType.connectionTimeout) {
        errorMessage = MESSAGES.CONNECTION_TIMEOUT;
      } else if (err.type == DioExceptionType.receiveTimeout) {
        errorMessage = MESSAGES.RECIVE_TIMEOUT;
      } else if (err.type == DioExceptionType.sendTimeout) {
        errorMessage = MESSAGES.RECIVE_TIMEOUT;
      } else {
        errorMessage = MESSAGES.UNEXPECTED_ERROR;
      }
    }

    final newError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: err.error,
      message: errorMessage,
    );
    // Pass the error to the next handler
    super.onError(newError, handler);
  }
}
