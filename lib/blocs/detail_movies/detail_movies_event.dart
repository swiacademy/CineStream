part of 'detail_movies_bloc.dart';

sealed class DetailMoviesEvent extends Equatable {
  const DetailMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetDetailMovies extends DetailMoviesEvent {
  final int movieId;
  final String language;

  const GetDetailMovies({required this.movieId, required this.language});

  @override
  List<Object> get props => [movieId, language];
}

class AddFavoriteMovies extends DetailMoviesEvent {
  final String mediaType;
  final int mediaId;
  final bool favorite;

  const AddFavoriteMovies(this.mediaType, this.mediaId, this.favorite);

  @override
  List<Object> get props => [mediaType, mediaId, favorite];
}

class RemoveFavoriteMovies extends DetailMoviesEvent {
  final String mediaType;
  final int mediaId;
  final bool favorite;

  const RemoveFavoriteMovies(this.mediaType, this.mediaId, this.favorite);

  @override
  List<Object> get props => [mediaType, mediaId, favorite];
}

class AddWatchlistMovies extends DetailMoviesEvent {
  final String mediaType;
  final int mediaId;
  final bool watchlist;

  const AddWatchlistMovies(this.mediaType, this.mediaId, this.watchlist);

  @override
  List<Object> get props => [mediaType, mediaId, watchlist];
}

class RemoveWatchlistMovies extends DetailMoviesEvent {
  final String mediaType;
  final int mediaId;
  final bool watchlist;

  const RemoveWatchlistMovies(this.mediaType, this.mediaId, this.watchlist);
}

class CheckMoviesIsFavoriteOrIsWatchlist extends DetailMoviesEvent {
  final int movieId;

  const CheckMoviesIsFavoriteOrIsWatchlist(this.movieId);

  @override
  List<Object> get props => [movieId];
}
