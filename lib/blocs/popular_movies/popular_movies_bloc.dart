import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_apps_bloc_pattern/models/popular_movies_model.dart';
import 'package:movies_apps_bloc_pattern/repositories/popular_movies/popular_movies_impl.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final PopularMoviesImpl popularMoviesImpl;

  PopularMoviesBloc(this.popularMoviesImpl)
      : super(PopularMoviesLoadingState()) {
    on<GetPopularMovies>((event, emit) async {
      emit(PopularMoviesLoadingState());

      try {
        final popularMovies = await popularMoviesImpl.getPopularMovies(
            event.language, event.page);

        emit(PopularMoviesLoadedState(popularMovies));
      } catch (e) {
        emit(PopularMoviesErrorState(e.toString()));
      }
    });
  }
}
