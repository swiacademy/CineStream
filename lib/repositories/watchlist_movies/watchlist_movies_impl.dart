import 'package:dio/dio.dart';
import 'package:movies_apps_bloc_pattern/models/watchlist_movies_model.dart';
import 'package:movies_apps_bloc_pattern/repositories/watchlist_movies/watchlist_movies_repository.dart';

import '../../utils/constants.dart';

class WatchlistMoviesImpl implements WatchlistMoviesRepository {
  @override
  Future<WatchlistMoviesModel> getWatchlistMovies(
      String language, int page) async {
    try {
      var url =
          "${Constants.API_BASE_URL}/3/account/${Constants.ACCOUNT_ID}/watchlist/movies";

      final dio = Dio();
      dio.options.headers["accept"] = "application/json";
      dio.options.headers["Authorization"] = "Bearer ${Constants.API_TOKEN}";
      dio.options.queryParameters = {"language": language, "page": page};

      Response response = await dio.get(url.toString());
      if (response.statusCode == 200) {
        var res = WatchlistMoviesModel.fromJson(response.data);
        return res;
      } else {
        throw Exception("Error get response");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
