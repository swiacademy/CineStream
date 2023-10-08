import 'package:movies_apps_bloc_pattern/models/detail_movies_model.dart';

abstract class DetailMoviesRepository {
  Future<DetailMoviesModel> getDetailMovies(int movieId, String language);
}
