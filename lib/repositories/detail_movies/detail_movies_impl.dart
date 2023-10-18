import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movies_apps_bloc_pattern/models/add_watchlist_model.dart';
import 'package:movies_apps_bloc_pattern/models/detail_movies_model.dart';
import 'package:movies_apps_bloc_pattern/models/movies_state_model.dart';
import 'package:movies_apps_bloc_pattern/models/remove_favorite_model.dart';
import 'package:movies_apps_bloc_pattern/models/remove_watchlist_model.dart';
import 'package:movies_apps_bloc_pattern/repositories/favorites/favorite_repository.dart';
import 'package:movies_apps_bloc_pattern/repositories/watchlists/watchlist_repository.dart';
import 'package:movies_apps_bloc_pattern/repositories/detail_movies/detail_movies_repository.dart';
import 'package:movies_apps_bloc_pattern/repositories/movies_state/movies_state_repository.dart';
import 'package:movies_apps_bloc_pattern/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/add_favorite_model.dart';

class DetailMoviesImpl
    implements
        DetailMoviesRepository,
        FavoriteRepository,
        WatchlistRepository,
        MoviesStateRepository {
  @override
  Future<DetailMoviesModel> getDetailMovies(
      int movieId, String language) async {
    try {
      var url = Uri.parse("${Constants.API_BASE_URL}/3/movie/$movieId");

      final dio = Dio();
      dio.options.headers["accept"] = "application/json";
      dio.options.headers["Authorization"] = "Bearer ${Constants.API_TOKEN}";
      dio.options.queryParameters = {
        "language": language,
        "append_to_response": "videos,credits"
      };

      Response response = await dio.get(url.toString());

      if (response.statusCode == 200) {
        var res = DetailMoviesModel.fromJson(response.data);
        return res;
      } else {
        throw Exception("Failed to load detail movies");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<AddFavoriteModel> addFavorite(
      String mediaType, int mediaId, bool favorite) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      var sessionId = sharedPreferences.getString("authSessionId");

      var url = Uri.parse(
          "${Constants.API_BASE_URL}/3/account/${Constants.ACCOUNT_ID}/favorite");

      final dio = Dio();
      dio.options.headers["accept"] = "application/json";
      dio.options.headers["content-type"] = "application/json";
      dio.options.headers["Authorization"] = "Bearer ${Constants.API_TOKEN}";
      dio.options.queryParameters = {
        "session_id": sessionId,
      };

      final params = {
        "media_type": mediaType,
        "media_id": mediaId,
        "favorite": favorite
      };

      Response response = await dio.post(url.toString(), data: params);

      if (response.statusCode == 201) {
        var res = AddFavoriteModel.fromJson(response.data);
        return res;
      } else {
        debugPrint(response.statusCode.toString());
        throw Exception("Failed add to favorite");
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<AddWatchlistModel> addWatchlist(
      String mediaType, int mediaId, bool watchlist) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      var sessionId = sharedPreferences.getString("authSessionId");

      var url = Uri.parse(
          "${Constants.API_BASE_URL}/3/account/${Constants.ACCOUNT_ID}/watchlist");

      final dio = Dio();
      dio.options.headers["accept"] = "application/json";
      dio.options.headers["content-type"] = "application/json";
      dio.options.headers["Authorization"] = "Bearer ${Constants.API_TOKEN}";
      dio.options.queryParameters = {
        "session_id": sessionId,
      };

      final params = {
        "media_type": mediaType,
        "media_id": mediaId,
        "watchlist": watchlist
      };

      Response response = await dio.post(url.toString(), data: params);

      if (response.statusCode == 201) {
        var res = AddWatchlistModel.fromJson(response.data);
        return res;
      } else {
        debugPrint(response.statusCode.toString());
        throw Exception("Failed add to watchlist");
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<MoviesStateModel> checkMoviesState(int movieId) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      var sessionId = sharedPreferences.getString("authSessionId");

      var url = Uri.parse(
          "${Constants.API_BASE_URL}/3/movie/$movieId/account_states");

      final dio = Dio();
      dio.options.headers["accept"] = "application/json";
      dio.options.headers["content-type"] = "application/json";
      dio.options.headers["Authorization"] = "Bearer ${Constants.API_TOKEN}";
      dio.options.queryParameters = {
        "session_id": sessionId,
      };

      Response response = await dio.get(url.toString());
      if (response.statusCode == 200) {
        var res = MoviesStateModel.fromJson(response.data);
        return res;
      } else {
        debugPrint(response.statusCode.toString());
        throw Exception("Failed get movies state");
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<RemoveFavoriteModel> removeFavorite(
      String mediaType, int mediaId, bool favorite) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      var sessionId = sharedPreferences.getString("authSessionId");

      var url = Uri.parse(
          "${Constants.API_BASE_URL}/3/account/${Constants.ACCOUNT_ID}/favorite");

      final dio = Dio();
      dio.options.headers["accept"] = "application/json";
      dio.options.headers["content-type"] = "application/json";
      dio.options.headers["Authorization"] = "Bearer ${Constants.API_TOKEN}";
      dio.options.queryParameters = {
        "session_id": sessionId,
      };

      final params = {
        "media_type": mediaType,
        "media_id": mediaId,
        "favorite": favorite
      };

      Response response = await dio.post(url.toString(), data: params);

      if (response.statusCode == 200) {
        var res = RemoveFavoriteModel.fromJson(response.data);
        return res;
      } else {
        debugPrint(response.statusCode.toString());
        throw Exception("Failed remove favorite");
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<RemoveWatchlistModel> removeWatchlist(
      String mediaType, int mediaId, bool watchlist) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      var sessionId = sharedPreferences.getString("authSessionId");

      var url = Uri.parse(
          "${Constants.API_BASE_URL}/3/account/${Constants.ACCOUNT_ID}/watchlist");

      final dio = Dio();
      dio.options.headers["accept"] = "application/json";
      dio.options.headers["content-type"] = "application/json";
      dio.options.headers["Authorization"] = "Bearer ${Constants.API_TOKEN}";
      dio.options.queryParameters = {
        "session_id": sessionId,
      };

      final params = {
        "media_type": mediaType,
        "media_id": mediaId,
        "watchlist": watchlist
      };

      Response response = await dio.post(url.toString(), data: params);

      if (response.statusCode == 200) {
        var res = RemoveWatchlistModel.fromJson(response.data);
        return res;
      } else {
        debugPrint(response.statusCode.toString());
        throw Exception("Failed remove watchlist");
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }
}
