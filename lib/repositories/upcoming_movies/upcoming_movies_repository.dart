import 'package:movies_apps_mvvm/models/upcoming_movies_model.dart';

abstract class UpcomingMoviesRepository {
  Future<UpcomingMoviesModel> getUpcomingMovies(String language, int page);
}
