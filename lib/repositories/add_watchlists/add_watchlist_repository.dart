import 'package:movies_apps_bloc_pattern/models/add_watchlist_model.dart';

abstract class AddWatchlistRepository {
  Future<AddWatchlistModel> addWatchlist(
      String mediaType, int mediaId, bool watchlist);
}
