import 'package:shared_preferences/shared_preferences.dart';

class SessionMovies {
  static Future<SharedPreferences> initSharedPreferences() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  static Future<bool> isLogin() async {
    var sharedPreferences = await initSharedPreferences();

    if (sharedPreferences.getString("sessionId") != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getSessionId() async {
    var sharedPreferences = await initSharedPreferences();

    return sharedPreferences.getString("sessionId").toString();
  }

  static Future<void> setSessionId(String sessionId) async {
    var sharedPreferences = await initSharedPreferences();

    sharedPreferences.setString("sessionId", sessionId);
  }
}
