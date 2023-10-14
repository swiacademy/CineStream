import 'package:movies_apps_bloc_pattern/models/favorite_movies_model.dart';

abstract class FavoriteMoviesRepository {
  Future<FavoriteMoviesModel> getFavoriteMovies(String languange, int page);
}
