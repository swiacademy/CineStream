import 'package:movies_apps_mvvm/models/popular_movies_model.dart';

abstract class PopularMoviesRepository {
  Future<PopularMoviesModel> getPopularMovies(String language, int page);
}
