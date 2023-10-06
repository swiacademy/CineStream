import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_apps_mvvm/models/detail_movies_model.dart';

class Button extends StatelessWidget {
  final String label;
  final String title;
  final DetailMoviesModel detailMoviesModel;
  const Button(
      {super.key,
      required this.label,
      required this.detailMoviesModel,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
          style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.white),
              backgroundColor: MaterialStatePropertyAll(Colors.red)),
          onPressed: () => {
                Get.toNamed("/trailer-movie", arguments: [
                  {
                    "youtubeId": detailMoviesModel.videos!.results![0].key,
                    "title": title
                  }
                ])
              },
          icon: const Icon(Icons.play_arrow),
          label: Text(label)),
    );
  }
}
