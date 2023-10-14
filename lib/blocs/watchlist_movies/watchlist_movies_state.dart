part of 'watchlist_movies_bloc.dart';

sealed class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();

  @override
  List<Object> get props => [];
}

final class WatchlistMoviesLoadingState extends WatchlistMoviesState {
  final String message;

  const WatchlistMoviesLoadingState(this.message);

  @override
  List<Object> get props => [message];
}

final class WatchlistMoviesLoadedState extends WatchlistMoviesState {
  final WatchlistMoviesModel watchlistMoviesModel;

  const WatchlistMoviesLoadedState(this.watchlistMoviesModel);

  @override
  List<Object> get props => [watchlistMoviesModel];
}

final class WatchlistMoviesErrorState extends WatchlistMoviesState {
  final String error;

  const WatchlistMoviesErrorState(this.error);

  @override
  List<Object> get props => [error];
}
