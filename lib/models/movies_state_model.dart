class MoviesStateModel {
  int? id;
  bool? favorite;
  bool? rated;
  bool? watchlist;

  MoviesStateModel({this.id, this.favorite, this.rated, this.watchlist});

  MoviesStateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    favorite = json['favorite'];
    rated = json['rated'];
    watchlist = json['watchlist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['favorite'] = favorite;
    data['rated'] = rated;
    data['watchlist'] = watchlist;
    return data;
  }
}
