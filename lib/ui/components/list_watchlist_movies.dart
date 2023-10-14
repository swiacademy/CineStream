import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:movies_apps_bloc_pattern/models/watchlist_movies_model.dart';

import 'package:movies_apps_bloc_pattern/utils/constants.dart';
import 'package:movies_apps_bloc_pattern/utils/limit_char.dart';

import '../../blocs/watchlist_movies/watchlist_movies_bloc.dart';

class ListWatchlistMovies extends StatefulWidget {
  const ListWatchlistMovies({super.key});

  @override
  State<ListWatchlistMovies> createState() => _ListWatchlistMoviesState();
}

class _ListWatchlistMoviesState extends State<ListWatchlistMovies> {
  final ScrollController scrollController = ScrollController();
  final List<Results> watchlist = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WatchlistMoviesBloc, WatchlistMoviesState>(
        listener: (context, state) {
      if (state is WatchlistMoviesLoadingState) {
        const snackBar = SnackBar(
          content: Text("Loading..."),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (state is WatchlistMoviesLoadedState &&
          state.watchlistMoviesModel.results!.isEmpty &&
          state.watchlistMoviesModel.page != 1) {
        Fluttertoast.showToast(
            msg: "No more data...",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: (Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black),
            textColor: (Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white),
            fontSize: 16.0);
      } else if (state is WatchlistMoviesErrorState) {
        Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }, builder: (context, state) {
      if (state is WatchlistMoviesLoadedState) {
        watchlist.addAll(state.watchlistMoviesModel.results!.toList());
        context.read<WatchlistMoviesBloc>().isFetching = false;

        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }

      if (state is WatchlistMoviesErrorState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.refresh),
            ),
            const SizedBox(height: 15),
            Text(state.error, textAlign: TextAlign.center),
          ],
        );
      }

      return ListView.separated(
          controller: scrollController
            ..addListener(() {
              if (scrollController.offset ==
                      scrollController.position.maxScrollExtent &&
                  !context.read<WatchlistMoviesBloc>().isFetching) {
                context.read<WatchlistMoviesBloc>()
                  ..isFetching = true
                  ..add(const GetWatchlistMovies("en-US"));
              }
            }),
          itemBuilder: (context, index) {
            return ListTile(
              isThreeLine: true,
              title: Text(
                watchlist[index].title!,
              ),
              subtitle: Text(
                  LimitChar.limitCharacters(watchlist[index].overview!, 100)),
              leading: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: CachedNetworkImage(
                  placeholderFadeInDuration: const Duration(seconds: 6),
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageUrl: (watchlist[index].posterPath != null
                      ? "${Constants.API_BASE_IMAGE_URL_POSTER_W154}${watchlist[index].posterPath}"
                      : Constants.IMAGE_NULL_PLACEHOLDER),
                  fit: BoxFit.fitWidth,
                  width: 40,
                ),
              ),
              onTap: () => {
                Get.toNamed("/detail-single-movie", arguments: [
                  {
                    "movieId": watchlist[index].id,
                    "title": watchlist[index].title
                  }
                ])
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(
                height: 1,
              ),
          itemCount: watchlist.length);
    });
  }
}
