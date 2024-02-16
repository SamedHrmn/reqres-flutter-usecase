import 'package:reqres_flutter_case/models/api_response_model.dart';

abstract class ApiService {
  Future<ApiResponse<T>> getRequest<T>(String path, {Map<String, dynamic>? queryParameters});
  Future<ApiResponse<T>> postRequest<T>(String path, dynamic data);
}
