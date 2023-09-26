part of 'now_playing_movies_bloc.dart';

sealed class NowPlayingMoviesEvent extends Equatable {
  const NowPlayingMoviesEvent();

  @override
  List<Object?> get props => [];
}

class GetPlayingNowMovies extends NowPlayingMoviesEvent {
  final String language;
  final int page;
  const GetPlayingNowMovies({required this.language, required this.page});

  @override
  List<Object?> get props => [page, language];
}
