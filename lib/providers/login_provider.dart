import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reqres_flutter_case/models/api_response_model.dart';
import 'package:reqres_flutter_case/models/user_model.dart';
import 'package:reqres_flutter_case/services/dio_service.dart';
import 'package:reqres_flutter_case/utilities/api_constant.dart';
import 'package:reqres_flutter_case/utilities/locator.dart';
import 'package:reqres_flutter_case/views/login_view.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, AsyncValue<ApiResponse<UserModel>>?>((ref) {
  return LoginNotifier();
});

class LoginNotifier extends StateNotifier<AsyncValue<ApiResponse<UserModel>>?> {
  LoginNotifier() : super(null);

  Future<void> login(WidgetRef ref) async {
    try {
      final response = await locator<DioService>().postRequest<Map<String, dynamic>>(
        ApiConstant.loginUrl,
        {
          "email": ref.read(loginEmailProvider),
          "password": ref.read(loginPasswordProvider),
        },
      );

      if (response.data?.containsKey("error") == true) {
        state = AsyncValue.data(ApiResponse(null, response.data?["error"]));
        return;
      }

      final userModel = UserModel(
        email: ref.read(loginEmailProvider),
        token: response.data!['token'],
      );

      state = AsyncValue.data(ApiResponse(userModel, null));
    } catch (e) {
      log(e.toString(), error: e);
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}
