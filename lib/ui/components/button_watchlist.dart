import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/detail_movies/detail_movies_bloc.dart';
import '../../utils/constants.dart';

class ButtonWatchlist extends StatefulWidget {
  final String mediaType;
  final int mediaId;
  final bool isWatchlist;
  const ButtonWatchlist(this.mediaType, this.mediaId, this.isWatchlist,
      {super.key});

  @override
  State<ButtonWatchlist> createState() => _ButtonWatchlistState();
}

class _ButtonWatchlistState extends State<ButtonWatchlist> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<DetailMoviesBloc>().add(AddWatchlistMovies(
            widget.mediaType, widget.mediaId, widget.isWatchlist));
      },
      icon: const Icon(Icons.bookmark_add_outlined),
      tooltip: Constants.LABEL_WATCHLIST,
    );
  }
}
