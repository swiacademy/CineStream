import 'package:movies_apps_bloc_pattern/models/upcoming_movies_model.dart';

abstract class UpcomingMoviesRepository {
  Future<UpcomingMoviesModel> getUpcomingMovies(String language, int page);
}
