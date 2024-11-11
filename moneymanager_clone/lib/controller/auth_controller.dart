import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:moneymanager_clone/services/apis/authentication_api.dart';

class AuthController extends GetxController {
  AuthenticationApi _authenticationApi = AuthenticationApi();
  bool isAuthentication = false;
  Future<bool> loginOrRegisterUser(
      {required String userName, required String password}) async {
    isAuthentication = true;
    update();
    String? responce = await _authenticationApi
        .loginOrRegisterApi({"username": userName, "password": password});
    isAuthentication = false;
    update();
    return responce != null;
  }
}
