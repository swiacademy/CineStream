part of 'upcoming_movies_bloc.dart';

sealed class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class GetUpcomingMovies extends MoviesEvent {
  final String language;
  final int page;
  const GetUpcomingMovies({required this.language, required this.page});

  @override
  List<Object> get props => [language, page];
}
