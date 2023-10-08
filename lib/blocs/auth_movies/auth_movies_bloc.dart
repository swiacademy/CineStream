import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_apps_bloc_pattern/models/detail_account_model.dart';
import 'package:movies_apps_bloc_pattern/repositories/login_movies/login_movies_impl.dart';

part 'auth_movies_event.dart';
part 'auth_movies_state.dart';

class AuthMoviesBloc extends Bloc<AuthMoviesEvent, AuthMoviesState> {
  final LoginMoviesImpl loginMoviesImpl;
  AuthMoviesBloc(this.loginMoviesImpl) : super(const AuthMoviesLoadingState()) {
    on<GetIsLoggedIn>((event, emit) async {
      emit(const AuthMoviesLoadingState());

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
      var login =
          await loginMoviesImpl.createSession(event.username, event.password);
      if (login.success!) {
        emit(AuthMoviesAuthenticatedState());
      } else {
        emit(AuthMoviesUnauthenticatedState());
      }
    });
  }
}
