import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movies_apps_mvvm/blocs/detail_movies/detail_movies_bloc.dart';
import 'package:movies_apps_mvvm/repositories/detail_movies/detail_movies_impl.dart';
import 'package:movies_apps_mvvm/ui/components/button.dart';
import 'package:movies_apps_mvvm/ui/components/cast_movies.dart';
import 'package:movies_apps_mvvm/ui/components/label.dart';
import 'package:movies_apps_mvvm/ui/components/title_movie.dart';
import 'package:movies_apps_mvvm/utils/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_apps_mvvm/utils/runtime_duration.dart';

import '../components/description_movie.dart';
import 'dart:io' show Platform;

class DetailMovie extends StatefulWidget {
  const DetailMovie({super.key});

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
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
    dynamic arguments = Get.arguments;

    final movieId = arguments[0]['movieId'];
    return RepositoryProvider(
      create: (context) => DetailMoviesImpl(),
      child: BlocProvider(
        create: (context) =>
            DetailMoviesBloc(RepositoryProvider.of<DetailMoviesImpl>(context))
              ..add(GetDetailMovies(movieId: movieId, language: "en-US")),
        child: Scaffold(
          appBar: AppBar(
            title: Text(arguments[0]['title'].toString()),
          ),
          body: SingleChildScrollView(
              child: BlocBuilder<DetailMoviesBloc, DetailMoviesState>(
            builder: (context, state) {
              if (state is DetailMoviesLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
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
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              imageUrl:
                                  "${Constans.API_BASE_IMAGE_URL_BACKDROP_W1280}${state.detailMoviesModel.backdropPath}"),
                        ),
                        Positioned(
                          bottom: (Platform.isAndroid ? 48 : 55),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      imageUrl:
                                          "${Constans.API_BASE_IMAGE_URL_POSTER_W92}${state.detailMoviesModel.posterPath}"),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8, top: 8),
                                    child: Text(
                                        state.detailMoviesModel.releaseDate
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8, top: 8),
                                    child: Text(
                                        "${state.detailMoviesModel.genres!.map((e) => e.name)}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8, top: 8),
                                    child: Text(
                                      RuntimeDuration.durationToString(state
                                          .detailMoviesModel.runtime!
                                          .toInt()),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8, top: 8),
                                    child: RatingBarIndicator(
                                      rating: state
                                              .detailMoviesModel.voteAverage!
                                              .toDouble() *
                                          0.5,
                                      itemBuilder: (context, index) =>
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
                                    padding:
                                        const EdgeInsets.only(left: 8, top: 8),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.transparent,
                                            child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                placeholderFadeInDuration:
                                                    const Duration(seconds: 6),
                                                placeholder: (context, url) =>
                                                    const Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                imageUrl:
                                                    "${Constans.API_BASE_IMAGE_URL_POSTER_W92}${state.detailMoviesModel.productionCompanies?[0].logoPath}"),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 4),
                                            child: Text(
                                              "${state.detailMoviesModel.productionCompanies?[0].name}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
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
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
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
                                        const Text("Original Language")
                                      ]),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Label(
                                            text:
                                                "${state.detailMoviesModel.productionCountries?[0].name}"),
                                        const Text("Region Of Origin")
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
                      padding:
                          const EdgeInsets.only(left: 8, bottom: 8, top: 0),
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
                          itemCount:
                              state.detailMoviesModel.credits?.cast?.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CastMovies(
                                  state.detailMoviesModel.credits?.cast?[index]
                                      .profilePath,
                                  state.detailMoviesModel.credits?.cast?[index]
                                      .name,
                                  state.detailMoviesModel.credits?.cast?[index]
                                      .character),
                            );
                          })),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Button(
                          label: Constans.LABEL_TRAILER,
                          detailMoviesModel: state.detailMoviesModel,
                          title: arguments[0]['title']),
                    )
                  ],
                );
              }

              if (state is DetailMoviesErrorState) {
                return const Center(
                  child: Text(Constans.ERROR_FETCH_DATA),
                );
              }

              return Container();
            },
          )),
        ),
      ),
    );
  }
}
