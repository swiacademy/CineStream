import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_apps_bloc_pattern/models/auth_session_model.dart';
import 'package:movies_apps_bloc_pattern/models/detail_account_model.dart';
import 'package:movies_apps_bloc_pattern/models/request_token_model.dart';
import 'package:movies_apps_bloc_pattern/models/signout_model.dart';
import 'package:movies_apps_bloc_pattern/models/validation_token_model.dart';
import 'package:movies_apps_bloc_pattern/repositories/detail_accounts/detail_account_repository.dart';
import 'package:movies_apps_bloc_pattern/repositories/login_movies/login_movies_repository.dart';
import 'package:movies_apps_bloc_pattern/repositories/request_tokens/request_token_repository.dart';
import 'package:movies_apps_bloc_pattern/repositories/signout_movies/signout_movies_repository.dart';

import 'package:movies_apps_bloc_pattern/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginMoviesImpl
    implements
        LoginMoviesRepository,
        RequestTokenRepository,
        DetailAccountRepository,
        SignoutMoviesRepository {
  @override
  Future<void> saveSessionId(String sessionId) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("authSessionId", sessionId);
  }

  @override
  Future<AuthSessionModel> createSession(
      String username, String password) async {
    try {
      var token = await getRequestToken();
      var vaidationToken =
          await validationToken(token.requestToken!, username, password);

      var url =
          Uri.parse("${Constants.API_BASE_URL}/3/authentication/session/new");
      final dio = Dio();
      dio.options.headers["accept"] = "application/json";
      dio.options.headers["content-type"] = "application/json";
      dio.options.queryParameters = {"api_key": Constants.API_KEY};
      dio.options.validateStatus = (status) => true;

      final params = {
        "request_token": vaidationToken.requestToken,
        "username": username,
        "password": password
      };

      Response response = await dio.post(url.toString(), data: params);

      if (response.statusCode == 200) {
        var res = AuthSessionModel.fromJson(response.data);
        saveSessionId(res.sessionId.toString());
        return res;
      } else {
        var res = AuthSessionModel.fromFailedJson(response.data);
        return res;
        // debugPrint(response.statusCode.toString());
        // throw Exception('Failed to create session');
      }
    } catch (e) {
      // debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<ValidationTokenModel> validationToken(
      String requestToken, String username, String password) async {
    try {
      var url = Uri.parse(
          "${Constants.API_BASE_URL}/3/authentication/token/validate_with_login");

      final dio = Dio();
      dio.options.headers["accept"] = "application/json";
      dio.options.headers["content-type"] = "application/json";
      dio.options.queryParameters = {"api_key": Constants.API_KEY};
      dio.options.validateStatus = (status) => true;

      final params = {
        "request_token": requestToken,
        "username": username,
        "password": password
      };

      Response response = await dio.post(url.toString(), data: params);

      if (response.statusCode == 200) {
        var res = ValidationTokenModel.fromJson(response.data);
        return res;
      } else {
        var res = ValidationTokenModel.fromFailedJson(response.data);
        return res;
        // debugPrint(response.statusCode.toString());
        // throw Exception('Failed to create session');
      }
    } catch (e) {
      // debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> getIsLoggedIn() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var isLoggedIn = sharedPreferences.getString("authSessionId");

    if (isLoggedIn == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<bool> skipLoggenIn() async {
    return true;
  }

  @override
  Future<bool> getSkipLogin() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var isSkipLogin = sharedPreferences.getString("isSkipLogin");
    debugPrint(isSkipLogin);
    if (isSkipLogin == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<void> setSkipLogin() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool("isSkipLogin", true);
  }

  @override
  Future<RequestTokenModel> getRequestToken() async {
    try {
      var url =
          Uri.parse("${Constants.API_BASE_URL}/3/authentication/token/new");

      final dio = Dio();
      dio.options.queryParameters = {"api_key": Constants.API_KEY};

      Response response = await dio.get(url.toString());

      if (response.statusCode == 200) {
        var res = RequestTokenModel.fromJson(response.data);
        return res;
      } else {
        var res = RequestTokenModel.fromFailedJson(response.data);
        return res;
      }
    } catch (e) {
      // debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<DetailAccountModel> getAccountDetail() async {
    try {
      var url = Uri.parse(
          "${Constants.API_BASE_URL}/3/account/${Constants.ACCOUNT_ID}");

      final dio = Dio();
      dio.options.headers["accept"] = "application/json";
      dio.options.headers["Authorization"] = "Bearer ${Constants.API_TOKEN}";

      Response response = await dio.get(url.toString());

      if (response.statusCode == 200) {
        var res = DetailAccountModel.fromJson(response.data);
        return res;
      } else {
        // debugPrint(response.statusCode.toString());
        throw Exception('Failed to create session');
      }
    } catch (e) {
      // debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<SignoutModel> getSignout() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    try {
      var isLoggedIn = sharedPreferences.getString("authSessionId");
      var url = Uri.parse("${Constants.API_BASE_URL}/3/authentication/session");

      final dio = Dio();
      dio.options.headers["accept"] = "application/json";
      dio.options.headers["Authorization"] = "Bearer ${Constants.API_TOKEN}";

      final params = {
        "session_id": isLoggedIn,
      };

      Response response = await dio.delete(url.toString(), data: params);

      if (response.statusCode == 200) {
        removeSessionId(isLoggedIn!);
        var res = SignoutModel.fromJson(response.data);
        return res;
      } else {
        // debugPrint(response.statusCode.toString());
        throw Exception('Failed to create session');
      }
    } catch (e) {
      // debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> removeSessionId(String sessionId) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove("authSessionId");
  }
}
