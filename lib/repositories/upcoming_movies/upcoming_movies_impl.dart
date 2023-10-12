import 'package:flutter/material.dart';
import 'package:movies_apps_bloc_pattern/models/upcoming_movies_model.dart';
import 'package:movies_apps_bloc_pattern/repositories/upcoming_movies/upcoming_movies_repository.dart';
import 'package:movies_apps_bloc_pattern/utils/constants.dart';
import 'package:dio/dio.dart';

import '../../utils/dio_headers.dart';

class UpcomingMoviesImpl implements UpcomingMoviesRepository {
  @override
  Future<UpcomingMoviesModel> getUpcomingMovies(
      String language, int page) async {
    try {
      var url = Uri.parse("${Constants.API_BASE_URL}/3/movie/upcoming");

      final dio = Dio();
      DioHeaders(dio, language, page);

      Response response = await dio.get(url.toString());

      if (response.statusCode == 200) {
        var res = UpcomingMoviesModel.fromJson(response.data);
        return res;
      } else {
        throw Exception('Failed to load upcoming movies');
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }
}
