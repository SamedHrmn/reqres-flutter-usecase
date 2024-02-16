import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reqres_flutter_case/models/api_response_model.dart';
import 'package:reqres_flutter_case/models/user_model.dart';
import 'package:reqres_flutter_case/services/dio_service.dart';
import 'package:reqres_flutter_case/utilities/api_constant.dart';
import 'package:reqres_flutter_case/utilities/locator.dart';

final usersProvider = StateNotifierProvider<UsersNotifier, AsyncValue<ApiResponse<List<UserModel>>>?>((ref) {
  return UsersNotifier();
});

class UsersNotifier extends StateNotifier<AsyncValue<ApiResponse<List<UserModel>>>?> {
  UsersNotifier() : super(null);

  Future<void> getAllUsers(WidgetRef ref) async {
    try {
      final response = await locator<DioService>().getRequest<Map<String, dynamic>>(
        ApiConstant.usersUrl,
      );

      if (response.data?.containsKey("error") == true) {
        state = AsyncValue.data(ApiResponse(null, response.data?["error"]));
        return;
      }

      final list = <UserModel>[];

      for (var element in response.data!["data"]) {
        list.add(UserModel.fromMap(element));
      }

      state = AsyncValue.data(ApiResponse(list, null));
    } catch (e) {
      log(e.toString(), error: e);
      state = AsyncValue.error('Something went wrong', StackTrace.current);
    }
  }
}
