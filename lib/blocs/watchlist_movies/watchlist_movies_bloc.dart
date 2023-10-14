import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_apps_bloc_pattern/models/watchlist_movies_model.dart';
import 'package:movies_apps_bloc_pattern/repositories/watchlist_movies/watchlist_movies_impl.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final WatchlistMoviesImpl watchlistMoviesImpl;
  int page = 1;
  int perpage = 20;
  bool isFetching = false;

  WatchlistMoviesBloc(this.watchlistMoviesImpl)
      : super(const WatchlistMoviesLoadingState("Loading...")) {
    on<GetWatchlistMovies>((event, emit) async {
      if (isFetching) {
        emit(const WatchlistMoviesLoadingState("Loading..."));
      }

      try {
        final watchlistMovies =
            await watchlistMoviesImpl.getWatchlistMovies("en-US", page);

        emit(WatchlistMoviesLoadedState(watchlistMovies));
        page++;
      } catch (e) {
        emit(WatchlistMoviesErrorState(e.toString()));
      }
    });
  }
}
