part of 'now_playing_movies_bloc.dart';

sealed class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

final class NowPlayingMoviesLoadingState extends NowPlayingMoviesState {}

final class NowPlayingMoviesLoadedState extends NowPlayingMoviesState {
  final NowPlayingMoviesModel nowPlayingMoviesModel;

  const NowPlayingMoviesLoadedState(this.nowPlayingMoviesModel);

  @override
  List<Object> get props => [nowPlayingMoviesModel];
}

final class NowPlayingMoviesErrorState extends NowPlayingMoviesState {
  final String error;

  const NowPlayingMoviesErrorState(this.error);

  @override
  List<Object> get props => [error];
}
