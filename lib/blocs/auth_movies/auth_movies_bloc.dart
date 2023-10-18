import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_apps_bloc_pattern/models/detail_account_model.dart';
import 'package:movies_apps_bloc_pattern/repositories/login_movies/login_movies_impl.dart';

part 'auth_movies_event.dart';
part 'auth_movies_state.dart';

class AuthMoviesBloc extends Bloc<AuthMoviesEvent, AuthMoviesState> {
  final LoginMoviesImpl loginMoviesImpl;
  AuthMoviesBloc(this.loginMoviesImpl)
      : super(const AuthMoviesLoadingState(false)) {
    on<GetIsLoggedIn>((event, emit) async {
      try {
        var loggedIn = await loginMoviesImpl.getIsLoggedIn();
        if (loggedIn) {
          emit(AuthMoviesAuthenticatedState());
        } else {
          emit(AuthMoviesUnauthenticatedState());
        }
      } catch (e) {
        emit(AuthMoviesErrorState(e.toString()));
      }
    });

    on<SkipLoggedIn>((event, emit) async {
      var skip = await loginMoviesImpl.skipLoggenIn();
      debugPrint(skip.toString());

      emit(AuthMoviesSkipAuthenticatedState(skip));
    });

    on<LoggedIn>((event, emit) async {
      if (event.username.isEmpty) {
        emit(const AuthMoviesLoadingState(true));
        emit(const AuthMoviesFailedState("username is required", false));
        emit(AuthMoviesUnauthenticatedState());
      } else if (event.password.isEmpty) {
        emit(const AuthMoviesLoadingState(true));
        emit(const AuthMoviesFailedState("password is required", false));
        emit(AuthMoviesUnauthenticatedState());
      } else {
        var login =
            await loginMoviesImpl.createSession(event.username, event.password);
        if (!login.success!) {
          emit(const AuthMoviesLoadingState(true));
          emit(const AuthMoviesFailedState(
              "Session denied. Please try again", false));
          emit(AuthMoviesUnauthenticatedState());
        } else {
          emit(AuthMoviesAuthenticatedState());
        }
      }
    });

    on<Signout>((event, emit) async {
      emit(AuthSignoutLoadingState());
      var signout = await loginMoviesImpl.getSignout();
      if (signout.success!) {
        emit(AuthSignoutSuccessState());
      } else {
        emit(const AuthSignoutErrorState("Error signout"));
      }
    });
  }
}
