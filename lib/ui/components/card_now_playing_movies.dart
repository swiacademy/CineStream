import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_apps_bloc_pattern/models/now_playing_movies_model.dart';
import 'package:movies_apps_bloc_pattern/utils/constants.dart';
import 'package:movies_apps_bloc_pattern/utils/limit_char.dart';
import 'package:get/get.dart';

class CardNowPlayingMovies extends StatelessWidget {
  final int itemCount;
  final List<Results>? nowPlayingMovies;
  const CardNowPlayingMovies(
      {super.key, required this.itemCount, required this.nowPlayingMovies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed("/detail-single-movie", arguments: [
                  {
                    "movieId": nowPlayingMovies![index].id,
                    "title": nowPlayingMovies![index].title
                  }
                ]);
              },
              child: Card(
                color: (Theme.of(context).brightness == Brightness.dark
                    ? const Color(0XFF4D2DB7)
                    : Colors.white),
                elevation: 4.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                          child: CachedNetworkImage(
                              placeholderFadeInDuration:
                                  const Duration(seconds: 6),
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              imageUrl: (nowPlayingMovies?[index].posterPath !=
                                      null
                                  ? "${Constants.API_BASE_IMAGE_URL_POSTER_W154}${nowPlayingMovies?[index].posterPath}"
                                  : Constants.IMAGE_NULL_PLACEHOLDER),
                              fit: BoxFit.fitWidth),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Flexible(
                            child: RichText(
                              text: TextSpan(
                                  text: LimitChar.limitCharacters(
                                      nowPlayingMovies![index].title.toString(),
                                      15),
                                  style: TextStyle(
                                      color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : const Color(0XFF4D2DB7)),
                                      fontWeight: FontWeight.w700)),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
