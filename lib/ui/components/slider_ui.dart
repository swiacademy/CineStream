import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_apps_bloc_pattern/models/upcoming_movies_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_apps_bloc_pattern/utils/constants.dart';

class SliderUI extends StatelessWidget {
  final int itemCount;
  final List<Results>? upcomingMovies;

  const SliderUI(
      {super.key, required this.itemCount, required this.upcomingMovies});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed("/detail-single-movie", arguments: [
                    {
                      "movieId": upcomingMovies![itemIndex].id,
                      "title": upcomingMovies![itemIndex].title
                    }
                  ]);
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 190,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: CachedNetworkImage(
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                      placeholderFadeInDuration: const Duration(seconds: 6),
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      imageUrl: (upcomingMovies![itemIndex].backdropPath != null
                          ? "${Constants.API_BASE_IMAGE_URL_BACKDROP_W1280}${upcomingMovies![itemIndex].backdropPath}"
                          : Constants.IMAGE_NULL_PLACEHOLDER),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          Constants.LABEL_UPCOMING,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            upcomingMovies![itemIndex].originalTitle.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      options: CarouselOptions(
          height: 230,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(seconds: 10)),
    );
  }
}
