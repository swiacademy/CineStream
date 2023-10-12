import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/detail_movies/detail_movies_bloc.dart';
import '../../utils/constants.dart';

class ButtonUnwatchlist extends StatefulWidget {
  final String mediaType;
  final int mediaId;
  final bool isWatchlist;
  const ButtonUnwatchlist(this.mediaType, this.mediaId, this.isWatchlist,
      {super.key});

  @override
  State<ButtonUnwatchlist> createState() => _ButtonUnwatchlistState();
}

class _ButtonUnwatchlistState extends State<ButtonUnwatchlist> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<DetailMoviesBloc>().add(RemoveWatchlistMovies(
            widget.mediaType, widget.mediaId, widget.isWatchlist));
      },
      icon: const Icon(Icons.bookmark),
      tooltip: Constants.LABEL_WATCHLIST,
    );
  }
}
