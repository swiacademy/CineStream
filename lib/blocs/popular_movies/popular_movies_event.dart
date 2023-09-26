part of 'popular_movies_bloc.dart';

sealed class PopularMoviesEvent extends Equatable {
  const PopularMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetPopularMovies extends PopularMoviesEvent {
  final String language;
  final int page;

  const GetPopularMovies({required this.language, required this.page});

  @override
  List<Object> get props => [language, page];
}
