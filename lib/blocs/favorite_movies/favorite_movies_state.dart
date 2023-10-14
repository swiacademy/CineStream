part of 'favorite_movies_bloc.dart';

sealed class FavoriteMoviesState extends Equatable {
  const FavoriteMoviesState();

  @override
  List<Object> get props => [];
}

final class FavoriteMoviesLoadingState extends FavoriteMoviesState {
  final String message;

  const FavoriteMoviesLoadingState(this.message);

  @override
  List<Object> get props => [message];
}

final class FavoriteMoviesLoadedState extends FavoriteMoviesState {
  final FavoriteMoviesModel favoriteMoviesModel;

  const FavoriteMoviesLoadedState(this.favoriteMoviesModel);

  @override
  List<Object> get props => [favoriteMoviesModel];
}

final class FavoriteMoviesErrorState extends FavoriteMoviesState {
  final String error;

  const FavoriteMoviesErrorState(this.error);

  @override
  List<Object> get props => [error];
}
