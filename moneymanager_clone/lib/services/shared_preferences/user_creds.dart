import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_strings.dart';

class UserCredintailStore {
  Future<void> setJwt(String token) async {
    final preps = await SharedPreferences.getInstance();
    await preps.setString(AppString.jwtKey, token);
  }

  Future<void> deleteJwt() async {
    final preps = await SharedPreferences.getInstance();
    await preps.remove(AppString.jwtKey);
  }

  Future<String?> getJwt() async {
    final preps = await SharedPreferences.getInstance();
    return preps.getString(AppString.jwtKey);
  }
}
