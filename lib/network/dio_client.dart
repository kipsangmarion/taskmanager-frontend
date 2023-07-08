import 'package:dio/dio.dart';
import 'package:taskmanager_frontend/network/api/endpoints.dart';

class DioClient {
  // injecting dio instance
  DioClient(this._dio) {
    _dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout =
      const Duration(milliseconds: Endpoints.connectionTimeout)
      ..options.receiveTimeout =
      const Duration(milliseconds: Endpoints.receiveTimeout)
      ..options.responseType = ResponseType.json
      ..interceptors.addAll([
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
      ]);
  }
  // dio instance
  final Dio _dio;
  // Get:-----------------------------------------------------------------------
  Future<Map<String, dynamic>?> get(
      String url, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>?>(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Map<String, dynamic>?> post(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Map<String, dynamic>?> put(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<Map<String, dynamic>?> delete(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}