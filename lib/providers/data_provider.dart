import 'package:cineflex/helpers/tmdb_api.dart';
import 'package:cineflex/models/cast_model.dart';
import 'package:cineflex/models/movie_model.dart';
import 'package:cineflex/models/tvshow_model.dart';

import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  List<Movie> _trending = [];

  List<Movie> get getTrending => _trending;

  void resetTrending() {
    _trending = [];
  }

  Future<void> getTrendingMedia() async {
    var responseData = await TmdbApi.getData(DataType.trending, 'all');
    _addMedia(responseData, 'results', _trending);
  }

  void _addMedia(responseData, String data, List list) {
    responseData[data].forEach((media) {
      if (media['media_type'] == 'movie') {
        list.add(
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
        list.add(
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

  Future<CastInfo> getPersonInfo(int id) async {
    var response = await TmdbApi.getPersonInfo(id);
    return CastInfo(
      id: response['id'],
      alsoKnownAs: response['also_known_as'],
      biography: response['biography'],
      birthDay: response['birthday'],
      deathDay: response['deathday'],
      knownForDepartment: response['known_for_department'],
      placeOfBirth: response['place_of_birth'],
    );
  }

  Future<List<Movie>> getKnownFor(int id) async {
    var response = await TmdbApi.getKnownFor(id);
    List<Movie> mediaList = [];
    _addMedia(response, 'cast', mediaList);
    _addMedia(response, 'crew', mediaList);
    return mediaList;
  }
}
