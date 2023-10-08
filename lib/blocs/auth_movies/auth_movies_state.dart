part of 'auth_movies_bloc.dart';

sealed class AuthMoviesState extends Equatable {
  const AuthMoviesState();

  @override
  List<Object> get props => [];
}

final class AuthMoviesLoadingState extends AuthMoviesState {
  const AuthMoviesLoadingState();

  @override
  List<Object> get props => [];
}

final class AuthMoviesAuthenticatedState extends AuthMoviesState {}

final class AuthMoviesUnauthenticatedState extends AuthMoviesState {}

final class AuthMoviesSkipAuthenticatedState extends AuthMoviesState {
  final bool skip;

  const AuthMoviesSkipAuthenticatedState(this.skip);

  @override
  List<Object> get props => [skip];
}

final class AuthMoviesErrorState extends AuthMoviesState {
  final String string;
  const AuthMoviesErrorState(this.string);

  @override
  List<Object> get props => [string];
}

final class AuthMoviesDetailAccountState extends AuthMoviesState {
  final DetailAccountModel detailAccountModel;

  const AuthMoviesDetailAccountState(this.detailAccountModel);

  @override
  List<Object> get props => [detailAccountModel];
}
