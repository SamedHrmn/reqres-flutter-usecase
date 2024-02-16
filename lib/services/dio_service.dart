import 'package:dio/dio.dart';
import 'package:reqres_flutter_case/models/api_response_model.dart';
import 'package:reqres_flutter_case/services/api_service.dart';

class DioService implements ApiService {
  final Dio _dio;

  DioService(this._dio);

  @override
  Future<ApiResponse<T>> getRequest<T>(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return ApiResponse<T>(response.data, null);
    } catch (e) {
      return ApiResponse(null, e.toString());
    }
  }

  @override
  Future<ApiResponse<T>> postRequest<T>(String path, Object? data) async {
    try {
      final response = await _dio.post(path, data: data);
      return ApiResponse<T>(response.data, null);
    } catch (e) {
      return ApiResponse(null, e.toString());
    }
  }
}
