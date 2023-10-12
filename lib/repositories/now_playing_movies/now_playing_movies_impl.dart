import 'package:dio/dio.dart';
import 'package:movies_apps_bloc_pattern/models/now_playing_movies_model.dart';
import 'package:movies_apps_bloc_pattern/repositories/now_playing_movies/now_playing_movies_repository.dart';
import 'package:movies_apps_bloc_pattern/utils/constants.dart';

import '../../utils/dio_headers.dart';

class NowPlayingMoviesImpl implements NowPlayingMoviesRepository {
  @override
  Future<NowPlayingMoviesModel> getNowPlayingMovies(
      String language, int page) async {
    try {
      var url = Uri.parse("${Constants.API_BASE_URL}/3/movie/now_playing");

      final dio = Dio();
      DioHeaders(dio, language, page);

      Response response = await dio.get(url.toString());

      if (response.statusCode == 200) {
        var res = NowPlayingMoviesModel.fromJson(response.data);
        return res;
      } else {
        throw Exception('Failed to load now playing movies');
      }
    } catch (e) {
      // debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }
}
