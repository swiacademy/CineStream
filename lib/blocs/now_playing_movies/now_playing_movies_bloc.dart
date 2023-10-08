import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_apps_bloc_pattern/models/now_playing_movies_model.dart';
import 'package:movies_apps_bloc_pattern/repositories/now_playing_movies/now_playing_movies_impl.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final NowPlayingMoviesImpl nowPlayingMoviesImpl;

  NowPlayingMoviesBloc(this.nowPlayingMoviesImpl)
      : super(NowPlayingMoviesLoadingState()) {
    on<GetPlayingNowMovies>((event, emit) async {
      emit(NowPlayingMoviesLoadingState());

      try {
        final nowPlayingMovies = await nowPlayingMoviesImpl.getNowPlayingMovies(
            event.language, event.page);
        emit(NowPlayingMoviesLoadedState(nowPlayingMovies));
      } catch (e) {
        emit(NowPlayingMoviesErrorState(e.toString()));
      }
    });
  }
}
