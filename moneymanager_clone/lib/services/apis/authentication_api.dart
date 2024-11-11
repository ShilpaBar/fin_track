import 'dart:convert';

import 'package:moneymanager_clone/constants/api_endpoint.dart';
import 'package:moneymanager_clone/services/interceptor.dart';
import 'package:moneymanager_clone/services/shared_preferences/user_creds.dart';
import 'package:pretty_logger/pretty_logger.dart';

import '../../utils/snackbar/snack_message.dart';

class AuthenticationApi {
  HttpConfig _httpConfig = HttpConfig();
  Future<String?> loginOrRegisterApi(Map<String, dynamic> body) async {
    try {
      String? responce =
          await _httpConfig.post(path: ApiEndPoint.logIn, body: body);
      if (responce != null) {
        final obj = jsonDecode(responce);
        SnackMessage.succesMessgae(msg: obj['message']);
        UserCredintailStore().setJwt(obj['data']['token']);
      }
      return responce;
    } catch (e) {
      PLog.red("Catch on Registration Api : ${e}");
      return null;
    }
  }
}
