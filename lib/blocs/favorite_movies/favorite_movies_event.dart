part of 'favorite_movies_bloc.dart';

sealed class FavoriteMoviesEvent extends Equatable {
  const FavoriteMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetFavoriteMovies extends FavoriteMoviesEvent {
  final String languange;

  const GetFavoriteMovies(this.languange);

  @override
  List<Object> get props => [languange];
}
