import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movies_apps_mvvm/blocs/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:movies_apps_mvvm/blocs/popular_movies/popular_movies_bloc.dart';
import 'package:movies_apps_mvvm/repositories/now_playing_movies/now_playing_movies_impl.dart';
import 'package:movies_apps_mvvm/repositories/popular_movies/popular_movies_impl.dart';
import 'package:movies_apps_mvvm/repositories/upcoming_movies/upcoming_movies_impl.dart';
import 'package:movies_apps_mvvm/ui/components/bottom_bar_navigation.dart';
import 'package:movies_apps_mvvm/ui/components/card_now_playing_movies.dart';
import 'package:movies_apps_mvvm/ui/components/card_popular_movies.dart';
import 'package:movies_apps_mvvm/ui/components/header.dart';
import 'package:movies_apps_mvvm/ui/components/label.dart';
import 'package:movies_apps_mvvm/ui/components/slider_ui.dart';
import 'package:movies_apps_mvvm/ui/pages/detail_movie.dart';
import 'package:movies_apps_mvvm/ui/pages/trailer_movie.dart';
import 'package:movies_apps_mvvm/utils/constants.dart';
import 'blocs/upcoming_movies/upcoming_movies_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        //Simple GetPage
        GetPage(name: '/detail-single-movie', page: () => const DetailMovie()),
        GetPage(name: '/trailer-movie', page: () => const TrailerMovie()),
        // GetPage with custom transitions and bindings
      ],
      title: Constans.APP_NAME,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => UpcomingMoviesImpl()),
          RepositoryProvider(create: (context) => NowPlayingMoviesImpl()),
          RepositoryProvider(create: (context) => PopularMoviesImpl()),
        ],
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentIndex = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

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
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: const BottomBarNavigationComponent(),
        body: SafeArea(
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
                          child: Text(Constans.ERROR_FETCH_DATA),
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
                          text: Constans.LABEL_NOW_PLAYING,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        BlocBuilder<NowPlayingMoviesBloc,
                            NowPlayingMoviesState>(
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
                                child: Text(Constans.ERROR_FETCH_DATA),
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
                          text: Constans.LABEL_POPULAR,
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
                                child: Text(Constans.ERROR_FETCH_DATA),
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
      ),
    );
  }
}
