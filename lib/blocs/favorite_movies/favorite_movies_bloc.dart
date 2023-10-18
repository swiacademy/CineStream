import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_apps_bloc_pattern/models/favorite_movies_model.dart';
import 'package:movies_apps_bloc_pattern/repositories/favorite_movies/favorite_movies_impl.dart';

part 'favorite_movies_event.dart';
part 'favorite_movies_state.dart';

class FavoriteMoviesBloc
    extends Bloc<FavoriteMoviesEvent, FavoriteMoviesState> {
  final FavoriteMoviesImpl favoriteMoviesImpl;
  int page = 1;
  int perpage = 20;
  bool isFetching = false;

  List<Results> favorites = [];

  FavoriteMoviesBloc(this.favoriteMoviesImpl)
      : super(const FavoriteMoviesLoadingState("Loading...")) {
    on<GetFavoriteMovies>((event, emit) async {
      if (isFetching) {
        emit(const FavoriteMoviesLoadingState("Loading..."));
      }

      try {
        final favoriteMovies =
            await favoriteMoviesImpl.getFavoriteMovies(event.languange, page);

        emit(FavoriteMoviesLoadedState(favoriteMovies));
        page++;
      } catch (e) {
        emit(FavoriteMoviesErrorState(e.toString()));
      }
    });
  }
}
