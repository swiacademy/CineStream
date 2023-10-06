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
