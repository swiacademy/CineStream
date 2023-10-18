import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_apps_bloc_pattern/blocs/favorite_movies/favorite_movies_bloc.dart';
import 'package:movies_apps_bloc_pattern/ui/pages/favorite_movies_page.dart';
import 'package:movies_apps_bloc_pattern/utils/constants.dart';
import 'package:movies_apps_bloc_pattern/utils/limit_char.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../pages/detail_favorites_watchlist_movies_page.dart';

class ListFavoriteMovies extends StatefulWidget {
  const ListFavoriteMovies({super.key});

  @override
  State<ListFavoriteMovies> createState() => _ListFavoriteMoviesState();
}

class _ListFavoriteMoviesState extends State<ListFavoriteMovies> {
  final ScrollController scrollController = ScrollController();
  bool isRefresh = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteMoviesBloc, FavoriteMoviesState>(
      listener: (context, state) {
        if (state is FavoriteMoviesLoadingState) {
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
        } else if (state is FavoriteMoviesLoadedState &&
            state.favoriteMoviesModel.results!.isEmpty &&
            state.favoriteMoviesModel.page != 1) {
          const snackBar = SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
            content: Text("No more favorite movies...",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is FavoriteMoviesErrorState) {
          Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        if (state is FavoriteMoviesLoadedState) {
          context
              .read<FavoriteMoviesBloc>()
              .favorites
              .addAll(state.favoriteMoviesModel.results!.toList());
          context.read<FavoriteMoviesBloc>().isFetching = false;

          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }

        if (state is FavoriteMoviesErrorState) {
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

        if (context.read<FavoriteMoviesBloc>().favorites.isEmpty) {
          return const Center(
            child: Text("No favorite movies"),
          );
        }

        return ListView.separated(
            controller: scrollController
              ..addListener(() {
                if (scrollController.offset ==
                        scrollController.position.maxScrollExtent &&
                    !context.read<FavoriteMoviesBloc>().isFetching) {
                  context.read<FavoriteMoviesBloc>()
                    ..isFetching = true
                    ..add(const GetFavoriteMovies("en-US"));
                }
              }),
            itemBuilder: (context, index) {
              return ListTile(
                isThreeLine: true,
                title: Text(
                  context.read<FavoriteMoviesBloc>().favorites[index].title!,
                ),
                subtitle: Text(LimitChar.limitCharacters(
                    context
                        .read<FavoriteMoviesBloc>()
                        .favorites[index]
                        .overview!,
                    100)),
                leading: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: CachedNetworkImage(
                    placeholderFadeInDuration: const Duration(seconds: 6),
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    imageUrl: (context
                                .read<FavoriteMoviesBloc>()
                                .favorites[index]
                                .posterPath !=
                            null
                        ? "${Constants.API_BASE_IMAGE_URL_POSTER_W154}${context.read<FavoriteMoviesBloc>().favorites[index].posterPath}"
                        : Constants.IMAGE_NULL_PLACEHOLDER),
                    fit: BoxFit.fitWidth,
                    width: 40,
                  ),
                ),
                onTap: () async {
                  isRefresh = await PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: DetailFavoritesWatchlistMovie(
                      movieId: context
                          .read<FavoriteMoviesBloc>()
                          .favorites[index]
                          .id,
                      title: context
                          .read<FavoriteMoviesBloc>()
                          .favorites[index]
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
                        screen: const FavoriteMoviesPage(), withNavBar: true);
                  }
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(
                  height: 1,
                ),
            itemCount: context.read<FavoriteMoviesBloc>().favorites.length);
      },
    );
  }
}
