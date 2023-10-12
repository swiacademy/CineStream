import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies_apps_bloc_pattern/models/popular_movies_model.dart';
import 'package:movies_apps_bloc_pattern/repositories/popular_movies/popular_movies_repository.dart';

import '../../utils/constants.dart';
import '../../utils/dio_headers.dart';

class PopularMoviesImpl implements PopularMoviesRepository {
  @override
  Future<PopularMoviesModel> getPopularMovies(String language, int page) async {
    try {
      var url = Uri.parse("${Constants.API_BASE_URL}/3/movie/popular");

      final dio = Dio();
      DioHeaders(dio, language, page);

      Response response = await dio.get(url.toString());

      if (response.statusCode == 200) {
        var res = PopularMoviesModel.fromJson(response.data);
        return res;
      } else {
        throw Exception('Failed to load popular movies');
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }
}
