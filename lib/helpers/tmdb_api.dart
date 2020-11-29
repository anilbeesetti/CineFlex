import 'dart:convert';

import 'package:cineflex/keys/private_keys.dart';
import 'package:http/http.dart' as http;

class Datatype {
  static const popular = 'popular';
  static const upcoming = 'upcoming';
  static const nowPlaying = 'now_playing';
  static const trending = 'trending';
  static const topRated = 'top_rated';
}

class TmdbApi {
  static const String _ApiKey = PrivateKey.apiKey;
  static final url = 'https://api.themoviedb.org/3/';
  static final basePhotoUrl = 'https://image.tmdb.org/t/p/w500/';
  static const mainUrl =
      'https://api.themoviedb.org/3/movie/596161/credits?api_key=62453b82f98db30d9a499cc700064b45&language=en-US';

  static Future<http.Response> _getResponse(url) async {
    return await http.get(url);
  }

  static Future<dynamic> getMovieCredits(int id) async {
    var finalUrl = url + 'movie/$id/credits?api_key=$_ApiKey&language=en-US';
    var respone = await _getResponse(finalUrl);
    return jsonDecode(respone.body);
  }

  static Future<dynamic> getMovie(int id) async {
    var finalUrl = url + 'movie/$id?api_key=$_ApiKey&language=en-US';
    var response = await _getResponse(finalUrl);
    return jsonDecode(response.body);
  }

  static Future<dynamic> getRecommendations(int id) async {
    var finalUrl =
        url + 'movie/$id/recommendations?api_key=$_ApiKey&language=en-US';
    var response = await _getResponse(finalUrl);
    return jsonDecode(response.body);
  }

  static Future<dynamic> getData(String dataType, String mediaType,
      {int page}) async {
    var finalUrl = url +
        '$mediaType/$dataType?api_key=$_ApiKey&language=en-US&page=${page ?? 1}';
    var response = await _getResponse(finalUrl);
    return jsonDecode(response.body);
  }
}
