import '../../models/add_favorite_model.dart';
import '../../models/remove_favorite_model.dart';

abstract class FavoriteRepository {
  Future<AddFavoriteModel> addFavorite(
      String mediaType, int mediaId, bool favorite);

  Future<RemoveFavoriteModel> removeFavorite(
      String mediaType, int mediaId, bool favorite);
}
