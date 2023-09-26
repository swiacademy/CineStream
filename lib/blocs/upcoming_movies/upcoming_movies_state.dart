part of 'upcoming_movies_bloc.dart';

sealed class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object?> get props => [];
}

//data loading
final class MoviesLoadingState extends MoviesState {
  const MoviesLoadingState();
}

//data loaded
final class MoviesLoadedState extends MoviesState {
  final UpcomingMoviesModel movies;
  const MoviesLoadedState(this.movies);

  @override
  List<Object?> get props => [movies];
}

//data error
final class MoviesErrorState extends MoviesState {
  final String error;

  const MoviesErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
