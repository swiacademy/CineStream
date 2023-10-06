import 'package:movies_apps_mvvm/models/detail_movies_model.dart';

abstract class DetailMoviesRepository {
  Future<DetailMoviesModel> getDetailMovies(int movieId, String language);
}
