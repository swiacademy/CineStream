import 'package:movies_apps_bloc_pattern/models/popular_movies_model.dart';

abstract class PopularMoviesRepository {
  Future<PopularMoviesModel> getPopularMovies(String language, int page);
}
