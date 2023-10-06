part of 'detail_movies_bloc.dart';

sealed class DetailMoviesState extends Equatable {
  const DetailMoviesState();

  @override
  List<Object> get props => [];
}

final class DetailMoviesLoadingState extends DetailMoviesState {}

final class DetailMoviesLoadedState extends DetailMoviesState {
  final DetailMoviesModel detailMoviesModel;

  const DetailMoviesLoadedState(this.detailMoviesModel);

  @override
  List<Object> get props => [detailMoviesModel];
}

final class DetailMoviesErrorState extends DetailMoviesState {
  final String error;

  const DetailMoviesErrorState(this.error);

  @override
  List<Object> get props => [error];
}
