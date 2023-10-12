import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:movies_apps_bloc_pattern/models/detail_account_model.dart';

import 'package:movies_apps_bloc_pattern/repositories/detail_accounts/detail_account_repository.dart';
import 'package:movies_apps_bloc_pattern/utils/constants.dart';

class DetailAccountImpl implements DetailAccountRepository {
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
        // debugPrint(res.username.toString());
        return res;
      } else {
        debugPrint(response.statusCode.toString());
        throw Exception('Failed to create session');
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }
}
