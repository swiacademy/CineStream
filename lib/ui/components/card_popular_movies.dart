import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_apps_mvvm/models/popular_movies_model.dart';

import 'package:movies_apps_mvvm/utils/constants.dart';

class CardPopularMovies extends StatelessWidget {
  final int itemCount;
  final List<Results>? popularMovies;
  const CardPopularMovies(
      {super.key, required this.itemCount, required this.popularMovies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return Card(
              color: (Theme.of(context).brightness == Brightness.dark
                  ? const Color(0XFF4D2DB7)
                  : Colors.white),
              elevation: 4.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      CachedNetworkImage(
                          imageUrl:
                              "${Constans.API_BASE_IMAGE_URL_POSTER_W154}${popularMovies?[index].posterPath}",
                          fit: BoxFit.fitWidth),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Expanded(
                          child: Text(
                            "${popularMovies?[index].originalTitle}",
                            style: const TextStyle(fontWeight: FontWeight.w700),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
