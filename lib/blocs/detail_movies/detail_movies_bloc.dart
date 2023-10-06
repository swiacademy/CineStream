import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_apps_mvvm/models/detail_movies_model.dart';
import 'package:movies_apps_mvvm/repositories/detail_movies/detail_movies_impl.dart';

part 'detail_movies_event.dart';
part 'detail_movies_state.dart';

class DetailMoviesBloc extends Bloc<DetailMoviesEvent, DetailMoviesState> {
  final DetailMoviesImpl detailMoviesImpl;

  DetailMoviesBloc(this.detailMoviesImpl) : super(DetailMoviesLoadingState()) {
    on<GetDetailMovies>((event, emit) async {
      emit(DetailMoviesLoadingState());

      try {
        final detailMovies = await detailMoviesImpl.getDetailMovies(
            event.movieId, event.language);
        emit(DetailMoviesLoadedState(detailMovies));
      } catch (e) {
        emit(DetailMoviesErrorState(e.toString()));
      }
    });
  }
}
