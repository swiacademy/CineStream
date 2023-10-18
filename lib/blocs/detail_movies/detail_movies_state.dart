part of 'detail_movies_bloc.dart';

sealed class DetailMoviesState extends Equatable {
  const DetailMoviesState();

  @override
  List<Object> get props => [];
}

final class DetailMoviesLoadingState extends DetailMoviesState {}

final class DetailMoviesLoadedState extends DetailMoviesState {
  final AddFavoriteModel? addFavoriteModel;
  final RemoveFavoriteModel? removeFavoriteModel;
  final AddWatchlistModel? addWatchlistModel;
  final RemoveWatchlistModel? removeWatchlistModel;
  final DetailMoviesModel detailMoviesModel;
  final bool isFavoriteClicked;
  final bool isWatchlistClicked;
  final bool? isFavorite;
  final bool? isWacthlist;

  const DetailMoviesLoadedState(
      {required this.detailMoviesModel,
      required this.addFavoriteModel,
      required this.removeFavoriteModel,
      required this.addWatchlistModel,
      required this.removeWatchlistModel,
      required this.isFavoriteClicked,
      required this.isWatchlistClicked,
      required this.isFavorite,
      required this.isWacthlist});

  @override
  List<Object> get props => [detailMoviesModel, isFavoriteClicked];
}

class DetailMoviesErrorState extends DetailMoviesState {
  final String error;

  const DetailMoviesErrorState(this.error);

  @override
  List<Object> get props => [error];
}

// favorite state
class FaroviteAddedState extends DetailMoviesState {
  final AddFavoriteModel addFavoriteModel;

  const FaroviteAddedState(this.addFavoriteModel);
  @override
  List<Object> get props => [addFavoriteModel];
}

class FaroviteRemovedState extends DetailMoviesState {}

class IsFavoriteState extends DetailMoviesState {}

class FaroviteErrorState extends DetailMoviesState {
  final String error;

  const FaroviteErrorState(this.error);

  @override
  List<Object> get props => [error];
}

//watchlist state
class WatchlistAddedState extends DetailMoviesState {
  final AddWatchlistModel addWatchlistModel;

  const WatchlistAddedState(this.addWatchlistModel);

  @override
  List<Object> get props => [addWatchlistModel];
}

class WatchlistRemovedState extends DetailMoviesState {}

class IsWatchlistState extends DetailMoviesState {}

class WatchlistErrorState extends DetailMoviesState {
  final String error;

  const WatchlistErrorState(this.error);

  @override
  List<Object> get props => [error];
}
