import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = 'Request to API server was cancelled';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Connection timeout with API server';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Connection timeout with API server';
        break;

      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;

      case DioExceptionType.unknown:
        if (dioError.message?.contains('SocketException') ?? false) {
          message = 'No Internet';
          break;
        }
        message = 'Unexpected error occurred';
        break;
    // ignore: no_default_cases
      default:
        message = 'Something went wrong';
        break;
    }
  }
  late String message;

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
      // ignore: avoid_dynamic_calls
        return error['message'] as String;
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}