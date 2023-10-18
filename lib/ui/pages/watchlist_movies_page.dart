import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_apps_bloc_pattern/repositories/watchlist_movies/watchlist_movies_impl.dart';
import 'package:movies_apps_bloc_pattern/ui/components/list_watchlist_movies.dart';
import 'package:movies_apps_bloc_pattern/utils/constants.dart';

import '../../blocs/watchlist_movies/watchlist_movies_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  const WatchlistMoviesPage({super.key});

  @override
  State<WatchlistMoviesPage> createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WatchlistMoviesImpl(),
      child: BlocProvider(
        create: (context) => WatchlistMoviesBloc(
            RepositoryProvider.of<WatchlistMoviesImpl>(context))
          ..add(const GetWatchlistMovies("en-US")),
        child: Scaffold(
          appBar: AppBar(
              title: const Text(
                "${Constants.LABEL_WATCHLIST} Movies",
              ),
              automaticallyImplyLeading: false),
          body: const ListWatchlistMovies(),
        ),
      ),
    );
  }
}
