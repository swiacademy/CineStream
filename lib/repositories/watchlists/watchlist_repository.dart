import 'package:movies_apps_bloc_pattern/models/add_watchlist_model.dart';
import 'package:movies_apps_bloc_pattern/models/remove_watchlist_model.dart';

abstract class WatchlistRepository {
  Future<AddWatchlistModel> addWatchlist(
      String mediaType, int mediaId, bool watchlist);
  Future<RemoveWatchlistModel> removeWatchlist(
      String mediaType, int mediaId, bool watchlist);
}
