import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_apps_bloc_pattern/models/add_favorite_model.dart';
import 'package:movies_apps_bloc_pattern/models/add_watchlist_model.dart';
import 'package:movies_apps_bloc_pattern/models/detail_movies_model.dart';
import 'package:movies_apps_bloc_pattern/repositories/detail_movies/detail_movies_impl.dart';

part 'detail_movies_event.dart';
part 'detail_movies_state.dart';

class DetailMoviesBloc extends Bloc<DetailMoviesEvent, DetailMoviesState> {
  final DetailMoviesImpl detailMoviesImpl;

  DetailMoviesBloc(this.detailMoviesImpl) : super(DetailMoviesLoadingState()) {
    on<GetDetailMovies>((event, emit) async {
      emit(DetailMoviesLoadingState());

      try {
        var moviesState =
            await detailMoviesImpl.checkMoviesState(event.movieId);

        final detailMovies = await detailMoviesImpl.getDetailMovies(
            event.movieId, event.language);

        emit(DetailMoviesLoadedState(detailMovies, null, null, false, false,
            moviesState.favorite, moviesState.watchlist));
      } catch (e) {
        emit(DetailMoviesErrorState(e.toString()));
      }
    });

    on<AddFavoriteMovies>((event, emit) async {
      try {
        var favorite = await detailMoviesImpl.addFavorite(
            event.mediaType, event.mediaId, event.favorite);

        if (favorite.success == true) {
          final detailMovies =
              await detailMoviesImpl.getDetailMovies(event.mediaId, "en-US");

          var moviesState =
              await detailMoviesImpl.checkMoviesState(event.mediaId);

          if (moviesState.favorite == true) {
            emit(DetailMoviesLoadedState(
                detailMovies,
                favorite,
                null,
                event.favorite,
                false,
                moviesState.favorite,
                moviesState.watchlist));
          }
        } else {
          emit(FaroviteErrorState(favorite.statusMessage.toString()));
        }
      } catch (e) {
        emit(FaroviteErrorState(e.toString()));
      }
    });

    on<AddWatchlistMovies>((event, emit) async {
      try {
        var watchlist = await detailMoviesImpl.addWatchlist(
            event.mediaType, event.mediaId, event.watchlist);
        if (watchlist.success == true) {
          final detailMovies =
              await detailMoviesImpl.getDetailMovies(event.mediaId, "en-US");

          var moviesState =
              await detailMoviesImpl.checkMoviesState(event.mediaId);

          if (moviesState.watchlist == true) {
            emit(DetailMoviesLoadedState(detailMovies, null, watchlist, false,
                event.watchlist, moviesState.favorite, moviesState.watchlist));
          }
        }
      } catch (e) {
        emit(FaroviteErrorState(e.toString()));
      }
    });
  }
}
