import 'package:movies_apps_bloc_pattern/models/movies_state_model.dart';

abstract class MoviesStateRepository {
  Future<MoviesStateModel> checkMoviesState(int movieId);
}
