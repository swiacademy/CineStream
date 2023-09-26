import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/upcoming_movies_model.dart';
import '../../repositories/upcoming_movies/upcoming_movies_impl.dart';

part 'upcoming_movies_event.dart';
part 'upcoming_movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final UpcomingMoviesImpl upcomingMoviesImpl;

  MoviesBloc(this.upcomingMoviesImpl) : super(const MoviesLoadingState()) {
    on<GetUpcomingMovies>((event, emit) async {
      emit(const MoviesLoadingState());

      try {
        final movies = await upcomingMoviesImpl.getUpcomingMovies(
            event.language, event.page);
        emit(MoviesLoadedState(movies));
      } catch (e) {
        emit(MoviesErrorState(e.toString()));
      }
    });
  }
}
