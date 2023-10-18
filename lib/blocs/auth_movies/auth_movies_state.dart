part of 'auth_movies_bloc.dart';

sealed class AuthMoviesState extends Equatable {
  const AuthMoviesState();

  @override
  List<Object> get props => [];
}

final class AuthMoviesLoadingState extends AuthMoviesState {
  final bool isLoading;
  const AuthMoviesLoadingState(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}

final class AuthMoviesAuthenticatedState extends AuthMoviesState {}

final class AuthMoviesUnauthenticatedState extends AuthMoviesState {}

final class AuthMoviesFailedState extends AuthMoviesState {
  final String message;
  final bool isLoading;

  const AuthMoviesFailedState(this.message, this.isLoading);

  @override
  List<Object> get props => [message];
}

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

final class AuthSignoutLoadingState extends AuthMoviesState {}

final class AuthSignoutSuccessState extends AuthMoviesState {}

final class AuthSignoutErrorState extends AuthMoviesState {
  final String error;

  const AuthSignoutErrorState(this.error);

  @override
  List<Object> get props => [error];
}

final class ShowToastState extends AuthMoviesState {
  final String toast;

  const ShowToastState(this.toast);

  @override
  List<Object> get props => [toast];
}
