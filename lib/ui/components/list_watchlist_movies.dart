import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_apps_bloc_pattern/ui/pages/watchlist_movies_page.dart';

import 'package:movies_apps_bloc_pattern/utils/constants.dart';
import 'package:movies_apps_bloc_pattern/utils/limit_char.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../blocs/watchlist_movies/watchlist_movies_bloc.dart';
import '../pages/detail_favorites_watchlist_movies_page.dart';

class ListWatchlistMovies extends StatefulWidget {
  const ListWatchlistMovies({super.key});

  @override
  State<ListWatchlistMovies> createState() => _ListWatchlistMoviesState();
}

class _ListWatchlistMoviesState extends State<ListWatchlistMovies> {
  final ScrollController scrollController = ScrollController();
  bool isRefresh = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WatchlistMoviesBloc, WatchlistMoviesState>(
        listener: (context, state) {
      if (state is WatchlistMoviesLoadingState) {
        const snackBar = SnackBar(
          content: Row(
            children: [
              CircularProgressIndicator(
                color: Colors.grey,
              ),
              SizedBox(
                width: 8,
              ),
              Text("Loading...")
            ],
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (state is WatchlistMoviesLoadedState &&
          state.watchlistMoviesModel.results!.isEmpty &&
          state.watchlistMoviesModel.page != 1) {
        const snackBar = SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
          content: Text("No more watchlist movies...",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
        context
            .read<WatchlistMoviesBloc>()
            .watchlist
            .addAll(state.watchlistMoviesModel.results!.toList());

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

      if (context.read<WatchlistMoviesBloc>().watchlist.isEmpty) {
        return const Center(
          child: Text("No watchlist movies"),
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
              context.read<WatchlistMoviesBloc>().watchlist[index].title!,
            ),
            subtitle: Text(LimitChar.limitCharacters(
                context.read<WatchlistMoviesBloc>().watchlist[index].overview!,
                100)),
            leading: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: CachedNetworkImage(
                placeholderFadeInDuration: const Duration(seconds: 6),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: (context
                            .read<WatchlistMoviesBloc>()
                            .watchlist[index]
                            .posterPath !=
                        null
                    ? "${Constants.API_BASE_IMAGE_URL_POSTER_W154}${context.read<WatchlistMoviesBloc>().watchlist[index].posterPath}"
                    : Constants.IMAGE_NULL_PLACEHOLDER),
                fit: BoxFit.fitWidth,
                width: 40,
              ),
            ),
            onTap: () async {
              isRefresh = await PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: DetailFavoritesWatchlistMovie(
                  movieId:
                      context.read<WatchlistMoviesBloc>().watchlist[index].id,
                  title: context
                      .read<WatchlistMoviesBloc>()
                      .watchlist[index]
                      .title,
                ),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );

              if (isRefresh) {
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                // ignore: use_build_context_synchronously
                PersistentNavBarNavigator.pushNewScreen(context,
                    screen: const WatchlistMoviesPage(), withNavBar: true);
              }
            },
          );
        },
        separatorBuilder: (context, index) => const Divider(
          height: 1,
        ),
        itemCount: context.read<WatchlistMoviesBloc>().watchlist.length,
      );
    });
  }
}
