part of 'auth_movies_bloc.dart';

sealed class AuthMoviesEvent extends Equatable {
  const AuthMoviesEvent();

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthMoviesEvent {
  final String username;
  final String password;

  const LoggedIn(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class ShowToast extends AuthMoviesEvent {
  final String message;

  const ShowToast(this.message);
  @override
  List<Object> get props => [message];
}

class SetSessionId extends AuthMoviesEvent {
  final String sessionId;

  const SetSessionId(this.sessionId);

  @override
  List<Object> get props => [sessionId];
}

class SkipLoggedIn extends AuthMoviesEvent {}

class GetIsLoggedIn extends AuthMoviesEvent {}

class Signout extends AuthMoviesEvent {}
