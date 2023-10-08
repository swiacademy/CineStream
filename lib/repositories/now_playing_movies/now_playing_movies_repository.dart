import 'package:movies_apps_bloc_pattern/models/now_playing_movies_model.dart';

abstract class NowPlayingMoviesRepository {
  Future<NowPlayingMoviesModel> getNowPlayingMovies(String language, int page);
}
