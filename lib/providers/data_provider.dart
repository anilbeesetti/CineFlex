import 'package:cineflex/helpers/tmdb_api.dart';
import 'package:cineflex/models/movie_model.dart';
import 'package:cineflex/models/tvshow_model.dart';

import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  List<Movie> _trending = [];

  List<Movie> get getTrending => _trending;

  void getTrendingMedia() async {
    var responseData = await TmdbApi.getTrending();
    _addMedia(responseData);
  }

  void _addMedia(responseData) {
    responseData['results'].forEach((media) {
      if (media['media_type'] == 'movie') {
        _trending.add(
          Movie(
            id: media['id'],
            overview: media['overview'],
            mediaType: media['media_type'],
            title: media['original_title'],
            backdropPath: media['backdrop_path'],
            orginalLanguage: media['original_language'],
            posterPath: media['poster_path'],
          ),
        );
      } else if (media['media_type'] == 'tv') {
        _trending.add(
          TvShow(
            id: media['id'],
            overview: media['overview'],
            mediaType: media['media_type'],
            title: media['original_name'],
            backdropPath: media['backdrop_path'],
            orginalLanguage: media['original_language'],
            posterPath: media['poster_path'],
          ),
        );
      }
    });
    notifyListeners();
  }
}
