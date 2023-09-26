part of 'popular_movies_bloc.dart';

sealed class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

final class PopularMoviesLoadingState extends PopularMoviesState {}

final class PopularMoviesLoadedState extends PopularMoviesState {
  final PopularMoviesModel popularMoviesModel;

  const PopularMoviesLoadedState(this.popularMoviesModel);

  @override
  List<Object> get props => [popularMoviesModel];
}

final class PopularMoviesErrorState extends PopularMoviesState {
  final String error;

  const PopularMoviesErrorState(this.error);

  @override
  List<Object> get props => [error];
}
