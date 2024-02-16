import 'package:flutter_test/flutter_test.dart';

import 'package:reqres_flutter_case/services/dio_service.dart';
import 'package:reqres_flutter_case/utilities/api_constant.dart';
import 'package:reqres_flutter_case/utilities/locator.dart';

void main() async {
  setupDependencies();
  test('Unit test', () async {
    final response = await locator<DioService>().postRequest(ApiConstant.registerUrl, {
      "username": "Samed",
      "email": "aaaa@gmail.com",
      "password": "aaaaa",
    });

    print(response.data);
    print(response.error);
  });
}
