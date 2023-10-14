part of 'watchlist_movies_bloc.dart';

sealed class WatchlistMoviesEvent extends Equatable {
  const WatchlistMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetWatchlistMovies extends WatchlistMoviesEvent {
  final String language;

  const GetWatchlistMovies(this.language);

  @override
  List<Object> get props => [language];
}
