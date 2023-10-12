import '../../models/add_favorite_model.dart';

abstract class AddFavoriteRepository {
  Future<AddFavoriteModel> addFavorite(
      String mediaType, int mediaId, bool favorite);
}
