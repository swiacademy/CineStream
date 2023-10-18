import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_apps_bloc_pattern/blocs/favorite_movies/favorite_movies_bloc.dart';
import 'package:movies_apps_bloc_pattern/repositories/favorite_movies/favorite_movies_impl.dart';
import 'package:movies_apps_bloc_pattern/ui/components/list_favorite_movies.dart';
import 'package:movies_apps_bloc_pattern/utils/constants.dart';

class FavoriteMoviesPage extends StatelessWidget {
  const FavoriteMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      lazy: true,
      create: (context) => FavoriteMoviesImpl(),
      child: BlocProvider(
        create: (context) => FavoriteMoviesBloc(
            RepositoryProvider.of<FavoriteMoviesImpl>(context))
          ..add(const GetFavoriteMovies("en-US")),
        child: Scaffold(
          appBar:
              AppBar(title: const Text("${Constants.LABEL_FAVORITE} Movies")),
          body: const ListFavoriteMovies(),
        ),
      ),
    );
  }
}
