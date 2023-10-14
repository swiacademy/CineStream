import 'package:movies_apps_bloc_pattern/models/watchlist_movies_model.dart';

abstract class WatchlistMoviesRepository {
  Future<WatchlistMoviesModel> getWatchlistMovies(String language, int page);
}
