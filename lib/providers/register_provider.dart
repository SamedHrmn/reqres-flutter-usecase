import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reqres_flutter_case/models/api_response_model.dart';
import 'package:reqres_flutter_case/models/user_model.dart';
import 'package:reqres_flutter_case/services/dio_service.dart';
import 'package:reqres_flutter_case/utilities/api_constant.dart';
import 'package:reqres_flutter_case/utilities/locator.dart';
import 'package:reqres_flutter_case/utilities/shared_pref_helper.dart';
import 'package:reqres_flutter_case/views/register_view.dart';

class RegisterNotifier extends StateNotifier<AsyncValue<ApiResponse<UserModel>>?> {
  RegisterNotifier() : super(null);

  Future<void> register(WidgetRef ref) async {
    try {
      final response = await locator<DioService>().postRequest<Map<String, dynamic>>(
        ApiConstant.registerUrl,
        {
          "username": ref.read(registerUsernameProvider),
          "email": ref.read(registerEmailProvider),
          "password": ref.read(registerPasswordProvider),
        },
      );

      if (response.data?.containsKey("error") == true) {
        state = AsyncValue.error(response.data?["error"]!, StackTrace.current);
        return;
      }

      // Save token to shared preferences.
      locator<SharedPrefHelper>().saveToken(response.data!['token']);

      final userModel = UserModel(
        email: ref.read(registerEmailProvider),
        id: response.data!['id'],
        token: response.data!['token'],
      );

      state = AsyncValue.data(ApiResponse(userModel, null));
    } catch (error) {
      state = AsyncValue.error(error.toString(), StackTrace.current);
    }
  }
}

final registerProvider = StateNotifierProvider<RegisterNotifier, AsyncValue<ApiResponse<UserModel>>?>(
  (ref) => RegisterNotifier(),
);
