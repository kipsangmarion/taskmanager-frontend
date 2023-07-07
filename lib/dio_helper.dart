import 'package:dio/dio.dart';

class DioClient {
  Dio _dio;

  DioClient(this._dio) {
    _dio = Dio();
    // Add any additional configurations or defaults here
  }

  Future<Response> get(String url, {Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onReceiveProgress,}) async {
    try {
      final Response response = await _dio.get(url, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onReceiveProgress: onReceiveProgress,);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String url, {data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await _dio.post(url, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String url, {data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await _dio.put(url, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(String url,{data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) async {
    try {
      final response = await _dio.delete(url, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
