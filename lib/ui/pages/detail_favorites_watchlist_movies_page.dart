import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_apps_bloc_pattern/blocs/auth_movies/auth_movies_bloc.dart';
import 'package:movies_apps_bloc_pattern/blocs/detail_movies/detail_movies_bloc.dart';
import 'package:movies_apps_bloc_pattern/blocs/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:movies_apps_bloc_pattern/repositories/detail_movies/detail_movies_impl.dart';
import 'package:movies_apps_bloc_pattern/repositories/login_movies/login_movies_impl.dart';
import 'package:movies_apps_bloc_pattern/repositories/watchlist_movies/watchlist_movies_impl.dart';
import 'package:movies_apps_bloc_pattern/ui/components/button_like.dart';
import 'package:movies_apps_bloc_pattern/ui/components/button_trailer.dart';
import 'package:movies_apps_bloc_pattern/ui/components/button_unlike.dart';
import 'package:movies_apps_bloc_pattern/ui/components/button_unwatchlist.dart';
import 'package:movies_apps_bloc_pattern/ui/components/button_watchlist.dart';
import 'package:movies_apps_bloc_pattern/ui/components/cast_movies.dart';
import 'package:movies_apps_bloc_pattern/ui/components/label.dart';
import 'package:movies_apps_bloc_pattern/ui/components/title_movie.dart';
import 'package:movies_apps_bloc_pattern/utils/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_apps_bloc_pattern/utils/runtime_duration.dart';
import '../components/description_movie.dart';
import 'dart:io' show Platform;

class DetailFavoritesWatchlistMovie extends StatefulWidget {
  final int? movieId;
  final String? title;
  const DetailFavoritesWatchlistMovie(
      {super.key, required this.movieId, required this.title});

  @override
  State<DetailFavoritesWatchlistMovie> createState() =>
      _DetailFavoritesWatchlistMovieState();
}

class _DetailFavoritesWatchlistMovieState
    extends State<DetailFavoritesWatchlistMovie> {
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
    // dynamic arguments = Get.arguments;

    // final movieId = arguments[0]['movieId'];
    final movieId = widget.movieId;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => DetailMoviesImpl()),
        RepositoryProvider(create: (context) => LoginMoviesImpl()),
        RepositoryProvider(create: (context) => WatchlistMoviesImpl()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DetailMoviesBloc(
                RepositoryProvider.of<DetailMoviesImpl>(context))
              ..add(GetDetailMovies(movieId: movieId!, language: "en-US")),
          ),
          BlocProvider(
            create: (context) => AuthMoviesBloc(RepositoryProvider.of(context))
              ..add(GetIsLoggedIn()),
          ),
          BlocProvider(
            create: (context) =>
                WatchlistMoviesBloc(RepositoryProvider.of(context))
                  ..add(const GetWatchlistMovies("en-US")),
          ),
        ],
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.title.toString()),
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context, true);
                  }),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: BlocListener<DetailMoviesBloc, DetailMoviesState>(
                  listener: (context, state) {
                    if (state is DetailMoviesLoadedState) {
                      if (state.removeFavoriteModel?.statusCode == 13 &&
                          state.removeFavoriteModel?.success == true) {
                        Fluttertoast.showToast(
                            msg: state.removeFavoriteModel!.statusMessage
                                .toString(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }

                      if (state.removeWatchlistModel?.statusCode == 13 &&
                          state.removeWatchlistModel?.success == true) {
                        setState(() {
                          BlocProvider.of<WatchlistMoviesBloc>(context)
                              .watchlist
                              .removeWhere((item) =>
                                  item.id == state.detailMoviesModel.id);
                        });

                        Fluttertoast.showToast(
                            msg: state.removeWatchlistModel!.statusMessage
                                .toString(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }

                      if (state.addFavoriteModel?.success == true) {
                        Fluttertoast.showToast(
                            msg: (state.addFavoriteModel!.statusCode == 1
                                ? "Movie has been added to favorite."
                                : state.addFavoriteModel!.statusMessage
                                    .toString()),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 3,
                            backgroundColor:
                                (Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                            textColor:
                                (Theme.of(context).brightness == Brightness.dark
                                    ? Colors.black
                                    : Colors.white),
                            fontSize: 16.0);
                      }

                      if (state.addWatchlistModel?.success == true) {
                        Fluttertoast.showToast(
                            msg: (state.addWatchlistModel!.statusCode == 1
                                ? "Movie has been added to watchlist."
                                : state.addWatchlistModel!.statusMessage
                                    .toString()),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 3,
                            backgroundColor:
                                (Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                            textColor:
                                (Theme.of(context).brightness == Brightness.dark
                                    ? Colors.black
                                    : Colors.white),
                            fontSize: 16.0);
                      }
                    }
                  },
                  child: Column(
                    children: [
                      BlocBuilder<DetailMoviesBloc, DetailMoviesState>(
                        builder: (context, state) {
                          if (state is DetailMoviesLoadingState) {
                            return const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          if (state is DetailMoviesLoadedState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Opacity(
                                      opacity: .4,
                                      child: CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          imageUrl: (state.detailMoviesModel
                                                      .backdropPath !=
                                                  null
                                              ? "${Constants.API_BASE_IMAGE_URL_BACKDROP_W1280}${state.detailMoviesModel.backdropPath}"
                                              : Constants
                                                  .IMAGE_NULL_PLACEHOLDER)),
                                    ),
                                    Positioned(
                                      bottom: (Platform.isAndroid ? 48 : 55),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: CachedNetworkImage(
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                  imageUrl: (state
                                                              .detailMoviesModel
                                                              .posterPath !=
                                                          null
                                                      ? "${Constants.API_BASE_IMAGE_URL_POSTER_W92}${state.detailMoviesModel.posterPath}"
                                                      : Constants
                                                          .IMAGE_NULL_PLACEHOLDER)),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, top: 8),
                                                child: Text(
                                                    state.detailMoviesModel
                                                        .releaseDate
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, top: 8),
                                                child: Text(
                                                    "${state.detailMoviesModel.genres!.map((e) => e.name)}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, top: 8),
                                                child: Text(
                                                  RuntimeDuration
                                                      .durationToString(state
                                                          .detailMoviesModel
                                                          .runtime!
                                                          .toInt()),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, top: 8),
                                                child: RatingBarIndicator(
                                                  rating: state
                                                          .detailMoviesModel
                                                          .voteAverage!
                                                          .toDouble() *
                                                      0.5,
                                                  itemBuilder:
                                                      (context, index) =>
                                                          const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  itemCount: 5,
                                                  itemSize: 25,
                                                  direction: Axis.horizontal,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, top: 8),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 10,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        child: CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            placeholderFadeInDuration:
                                                                const Duration(
                                                                    seconds: 6),
                                                            placeholder: (context,
                                                                    url) =>
                                                                const Center(
                                                                    child:
                                                                        CircularProgressIndicator()),
                                                            imageUrl: (state
                                                                        .detailMoviesModel
                                                                        .productionCompanies?[
                                                                            0]
                                                                        .logoPath !=
                                                                    null
                                                                ? "${Constants.API_BASE_IMAGE_URL_POSTER_W92}${state.detailMoviesModel.productionCompanies?[0].logoPath}"
                                                                : Constants
                                                                    .IMAGE_NULL_PLACEHOLDER)),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 4),
                                                        child: Text(
                                                          "${state.detailMoviesModel.productionCompanies?[0].name}",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .labelSmall!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Label(
                                                        text:
                                                            "${state.detailMoviesModel.originalLanguage?.toString()} "),
                                                    const Text(
                                                        "Original Language")
                                                  ]),
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Label(
                                                        text:
                                                            "${state.detailMoviesModel.productionCountries?[0].name}"),
                                                    const Text(
                                                        "Region Of Origin")
                                                  ]),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TitleMovie(
                                      text:
                                          "${state.detailMoviesModel.originalTitle?.toString()} (${state.detailMoviesModel.releaseDate.toString().split("-")[0]})"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, bottom: 8, top: 0),
                                  child: DescriptionMovie(
                                      text:
                                          "${state.detailMoviesModel.tagline?.toString()}"),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Label(text: "Overview"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, bottom: 8, top: 0, right: 8),
                                  child: DescriptionMovie(
                                      text:
                                          "${state.detailMoviesModel.overview?.toString()}"),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Label(text: "Cast"),
                                ),
                                SizedBox(
                                  height: 160,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.detailMoviesModel.credits
                                          ?.cast?.length,
                                      itemBuilder: ((context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CastMovies(
                                              state.detailMoviesModel.credits
                                                  ?.cast?[index].profilePath,
                                              state.detailMoviesModel.credits
                                                  ?.cast?[index].name,
                                              state.detailMoviesModel.credits
                                                  ?.cast?[index].character),
                                        );
                                      })),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.only(
                                      top: 8, left: 16, right: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ButtonTrailer(
                                            label: Constants.LABEL_TRAILER,
                                            detailMoviesModel:
                                                state.detailMoviesModel,
                                            // title: arguments[0]['title']),
                                            title: widget.title.toString()),
                                      ),
                                      BlocBuilder<AuthMoviesBloc,
                                          AuthMoviesState>(
                                        builder: (context, state) {
                                          if (state
                                              is AuthMoviesAuthenticatedState) {
                                            return const Spacer();
                                          }
                                          return Container();
                                        },
                                      ),
                                      BlocBuilder<AuthMoviesBloc,
                                          AuthMoviesState>(
                                        builder: (context, state) {
                                          if (state
                                              is AuthMoviesUnauthenticatedState) {
                                            return Container();
                                          }

                                          if (state
                                              is AuthMoviesAuthenticatedState) {
                                            return BlocBuilder<DetailMoviesBloc,
                                                DetailMoviesState>(
                                              builder: (context, state) {
                                                if (state
                                                    is DetailMoviesLoadedState) {
                                                  return (state.isFavorite ==
                                                          false
                                                      ? ButtonLike("movie",
                                                          movieId!, true)
                                                      : ButtonUnlike("movie",
                                                          movieId!, false));
                                                }

                                                return Container();
                                              },
                                            );
                                          }

                                          return Container();
                                        },
                                      ),
                                      BlocBuilder<AuthMoviesBloc,
                                          AuthMoviesState>(
                                        builder: (context, state) {
                                          if (state
                                              is AuthMoviesUnauthenticatedState) {
                                            return Container();
                                          }

                                          if (state
                                              is AuthMoviesAuthenticatedState) {
                                            return BlocBuilder<DetailMoviesBloc,
                                                DetailMoviesState>(
                                              builder: (context, state) {
                                                if (state
                                                    is DetailMoviesLoadedState) {
                                                  return (state.isWacthlist ==
                                                          false
                                                      ? ButtonWatchlist("movie",
                                                          movieId!, true)
                                                      : ButtonUnwatchlist(
                                                          "movie",
                                                          movieId!,
                                                          false));
                                                }

                                                return Container();
                                              },
                                            );
                                          }

                                          return Container();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }

                          if (state is DetailMoviesErrorState) {
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
              ),
            )),
      ),
    );
  }
}
