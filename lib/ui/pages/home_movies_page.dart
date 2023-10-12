import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/now_playing_movies/now_playing_movies_bloc.dart';
import '../../blocs/popular_movies/popular_movies_bloc.dart';
import '../../blocs/upcoming_movies/upcoming_movies_bloc.dart';
import '../../repositories/now_playing_movies/now_playing_movies_impl.dart';
import '../../repositories/popular_movies/popular_movies_impl.dart';
import '../../repositories/upcoming_movies/upcoming_movies_impl.dart';
import '../../utils/constants.dart';
import '../components/card_now_playing_movies.dart';
import '../components/card_popular_movies.dart';
import '../components/header.dart';
import '../components/label.dart';
import '../components/slider_ui.dart';

class HomeMoviesPage extends StatefulWidget {
  const HomeMoviesPage({super.key});

  @override
  State<HomeMoviesPage> createState() => _HomeMoviesPageState();
}

class _HomeMoviesPageState extends State<HomeMoviesPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesBloc>(
            create: (context) => MoviesBloc(
                  RepositoryProvider.of<UpcomingMoviesImpl>(context),
                )..add(const GetUpcomingMovies(language: "en-US", page: 1))),
        BlocProvider<NowPlayingMoviesBloc>(
            create: (context) => NowPlayingMoviesBloc(
                  RepositoryProvider.of<NowPlayingMoviesImpl>(context),
                )..add(const GetPlayingNowMovies(language: "en-US", page: 1))),
        BlocProvider<PopularMoviesBloc>(
            create: (context) => PopularMoviesBloc(
                  RepositoryProvider.of<PopularMoviesImpl>(context),
                )..add(const GetPopularMovies(language: "en-US", page: 2)))
      ],

      child: SafeArea(
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Header(),
                const SizedBox(
                  height: 8,
                ),
                BlocBuilder<MoviesBloc, MoviesState>(
                  builder: (context, state) {
                    if (state is MoviesLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is MoviesLoadedState) {
                      return SliderUI(
                        itemCount: state.movies.results!.length,
                        upcomingMovies: state.movies.results,
                      );
                    }
                    if (state is MoviesErrorState) {
                      return const Center(
                        child: Text(Constants.ERROR_FETCH_DATA),
                      );
                    }

                    return Container();
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Label(
                        text: Constants.LABEL_NOW_PLAYING,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
                        builder: (context, state) {
                          if (state is NowPlayingMoviesLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is NowPlayingMoviesLoadedState) {
                            return CardNowPlayingMovies(
                              itemCount:
                                  state.nowPlayingMoviesModel.results!.length,
                              nowPlayingMovies:
                                  state.nowPlayingMoviesModel.results,
                            );
                          }
                          if (state is NowPlayingMoviesErrorState) {
                            return const Center(
                              child: Text(Constants.ERROR_FETCH_DATA),
                            );
                          }

                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Label(
                        text: Constants.LABEL_POPULAR,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                        builder: (context, state) {
                          if (state is PopularMoviesLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is PopularMoviesLoadedState) {
                            return CardPopularMovies(
                              itemCount:
                                  state.popularMoviesModel.results!.length,
                              popularMovies: state.popularMoviesModel.results,
                            );
                          }
                          if (state is PopularMoviesErrorState) {
                            return const Center(
                              child: Text(Constants.ERROR_FETCH_DATA),
                            );
                          }

                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
