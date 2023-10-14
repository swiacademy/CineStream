import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:movies_apps_bloc_pattern/blocs/favorite_movies/favorite_movies_bloc.dart';
import 'package:movies_apps_bloc_pattern/models/favorite_movies_model.dart';
import 'package:movies_apps_bloc_pattern/utils/constants.dart';
import 'package:movies_apps_bloc_pattern/utils/limit_char.dart';

class ListFavoriteMovies extends StatefulWidget {
  const ListFavoriteMovies({super.key});

  @override
  State<ListFavoriteMovies> createState() => _ListFavoriteMoviesState();
}

class _ListFavoriteMoviesState extends State<ListFavoriteMovies> {
  final ScrollController scrollController = ScrollController();
  final List<Results> favorites = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteMoviesBloc, FavoriteMoviesState>(
      listener: (context, state) {
        if (state is FavoriteMoviesLoadingState) {
          const snackBar = SnackBar(
            content: Text("Loading..."),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is FavoriteMoviesLoadedState &&
            state.favoriteMoviesModel.results!.isEmpty &&
            state.favoriteMoviesModel.page != 1) {
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
          favorites.addAll(state.favoriteMoviesModel.results!.toList());
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
                  favorites[index].title!,
                ),
                subtitle: Text(
                    LimitChar.limitCharacters(favorites[index].overview!, 100)),
                leading: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: CachedNetworkImage(
                    placeholderFadeInDuration: const Duration(seconds: 6),
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    imageUrl: (favorites[index].posterPath != null
                        ? "${Constants.API_BASE_IMAGE_URL_POSTER_W154}${favorites[index].posterPath}"
                        : Constants.IMAGE_NULL_PLACEHOLDER),
                    fit: BoxFit.fitWidth,
                    width: 40,
                  ),
                ),
                onTap: () => {
                  Get.toNamed("/detail-single-movie", arguments: [
                    {
                      "movieId": favorites[index].id,
                      "title": favorites[index].title
                    }
                  ])
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(
                  height: 1,
                ),
            itemCount: favorites.length);
      },
    );
  }
}
