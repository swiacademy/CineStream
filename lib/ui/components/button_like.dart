import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_apps_bloc_pattern/blocs/detail_movies/detail_movies_bloc.dart';
import 'package:movies_apps_bloc_pattern/utils/constants.dart';

class ButtonLike extends StatefulWidget {
  final String mediaType;
  final int mediaId;
  final bool isFavorite;
  const ButtonLike(this.mediaType, this.mediaId, this.isFavorite, {super.key});

  @override
  State<ButtonLike> createState() => _ButtonLikeState();
}

class _ButtonLikeState extends State<ButtonLike> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<DetailMoviesBloc>().add(AddFavoriteMovies(
            widget.mediaType, widget.mediaId, widget.isFavorite));
      },
      icon: const Icon(Icons.favorite_border),
      tooltip: Constants.LABEL_FAVORITE,
    );
  }
}
