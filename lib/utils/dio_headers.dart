import 'package:dio/dio.dart';

import 'constants.dart';

// ignore: non_constant_identifier_names
Future<void> DioHeaders(Dio dio, String language, int? page) async {
  dio.options.headers["accept"] = "application/json";
  dio.options.headers["Authorization"] = "Bearer ${Constants.API_TOKEN}";
  dio.options.queryParameters = {
    "language": language,
    "page": page,
  };
}
