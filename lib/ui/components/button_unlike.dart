import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_apps_bloc_pattern/blocs/detail_movies/detail_movies_bloc.dart';
import 'package:movies_apps_bloc_pattern/utils/constants.dart';

class ButtonUnlike extends StatefulWidget {
  final String mediaType;
  final int mediaId;
  final bool isFavorite;
  const ButtonUnlike(this.mediaType, this.mediaId, this.isFavorite,
      {super.key});

  @override
  State<ButtonUnlike> createState() => _ButtonUnlikeState();
}

class _ButtonUnlikeState extends State<ButtonUnlike> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<DetailMoviesBloc>().add(RemoveFavoriteMovies(
            widget.mediaType, widget.mediaId, widget.isFavorite));
      },
      icon: const Icon(Icons.favorite),
      tooltip: Constants.LABEL_FAVORITE,
    );
  }
}
