import 'dart:convert';

import 'package:cineflex/keys/private_keys.dart';
import 'package:http/http.dart' as http;

class DataType {
  static const popular = 'popular';
  static const upcoming = 'upcoming';
  static const nowPlaying = 'now_playing';
  static const trending = 'trending';
  static const topRated = 'top_rated';
  static const onTheAir = 'on_the_air';
}

class TmdbApi {
  static const String _ApiKey = PrivateKey.apiKey;
  static final url = 'https://api.themoviedb.org/3/';
  static final basePhotoUrl = 'https://image.tmdb.org/t/p/w500/';

  static Future<http.Response> _getResponse(url) async {
    return await http.get(url);
  }

  static Future<dynamic> getCredits(int id, String mediaType) async {
    var finalUrl =
        url + '$mediaType/$id/credits?api_key=$_ApiKey&language=en-US';
    var respone = await _getResponse(finalUrl);
    return jsonDecode(respone.body);
  }

  static Future<dynamic> getTvShowCredits(int tvId, int seasonNumber) async {
    var finalUrl = url +
        'tv/$tvId/season/$seasonNumber/credits?api_key=$_ApiKey&language=en-US';
    var respone = await _getResponse(finalUrl);
    return jsonDecode(respone.body);
  }

  static Future<dynamic> getMediaData(int id, String mediaType) async {
    var finalUrl = url + '$mediaType/$id?api_key=$_ApiKey&language=en-US';
    var response = await _getResponse(finalUrl);
    return jsonDecode(response.body);
  }

  static Future<dynamic> getRecommendations(int id, String mediaType) async {
    var finalUrl =
        url + '$mediaType/$id/recommendations?api_key=$_ApiKey&language=en-US';
    var response = await _getResponse(finalUrl);
    return jsonDecode(response.body);
  }

  static Future<dynamic> getData(String dataType, String mediaType,
      {int page, String timePeriod = 'day'}) async {
    var finalUrl = url +
        '$mediaType/$dataType?api_key=$_ApiKey&language=en-US&page=${page ?? 1}';
    if (dataType == DataType.trending) {
      finalUrl = url + '$dataType/$mediaType/$timePeriod?api_key=$_ApiKey';
    }
    var response = await _getResponse(finalUrl);
    return jsonDecode(response.body);
  }

  static Future<dynamic> getSeasonInfo(int tvId, int seasonNumber) async {
    var finalUrl =
        url + 'tv/$tvId/season/$seasonNumber?api_key=$_ApiKey&language=en-US';
    var response = await _getResponse(finalUrl);
    return jsonDecode(response.body);
  }
}
// static const mainUrl =
// 'https://api.themoviedb.org/3/movie/596161/credits?api_key=62453b82f98db30d9a499cc700064b45&language=en-US';
