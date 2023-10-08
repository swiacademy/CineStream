import 'package:dio/dio.dart';
import 'package:movies_apps_bloc_pattern/models/detail_movies_model.dart';
import 'package:movies_apps_bloc_pattern/repositories/detail_movies/detail_movies_repository.dart';
import 'package:movies_apps_bloc_pattern/utils/constants.dart';

class DetailMoviesImpl implements DetailMoviesRepository {
  @override
  Future<DetailMoviesModel> getDetailMovies(
      int movieId, String language) async {
    try {
      var url = Uri.parse("${Constans.API_BASE_URL}/3/movie/$movieId");

      final dio = Dio();
      dio.options.headers["accept"] = "application/json";
      dio.options.headers["Authorization"] = "Bearer ${Constans.API_TOKEN}";
      dio.options.queryParameters = {
        "language": language,
        "append_to_response": "videos,credits"
      };

      Response response = await dio.get(url.toString());

      if (response.statusCode == 200) {
        var res = DetailMoviesModel.fromJson(response.data);
        return res;
      } else {
        throw Exception("Failed to load detail movies");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
