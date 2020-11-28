import 'dart:convert';

import 'package:http/http.dart' as http;

class TmdbApi {
  static const String _ApiKey = '62453b82f98db30d9a499cc700064b45';
  static final url = 'https://api.themoviedb.org/3/';
  static final basePhotoUrl = 'https://image.tmdb.org/t/p/w500/';
  static const mainUrl =
      'https://api.themoviedb.org/3/movie/596161/credits?api_key=62453b82f98db30d9a499cc700064b45&language=en-US';

  static Future<http.Response> _getResponse(url) async {
    return await http.get(url);
  }

  static Future<dynamic> getPopularMoives() async {
    var finalUrl = url + 'movie/popular?api_key=$_ApiKey&language=en-US&page=1';
    var response = await _getResponse(finalUrl);
    return jsonDecode(response.body);
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

  static Future<dynamic> getTrending() async {
    var finalUrl = url + 'trending/all/day?api_key=$_ApiKey&language=en-US';
    var response = await _getResponse(finalUrl);
    return jsonDecode(response.body);
  }

  static Future<dynamic> getPopularTvShows() async {
    var finalUrl = url + 'tv/popular?api_key=$_ApiKey&language=en-US&page=1';
    var response = await _getResponse(finalUrl);
    return jsonDecode(response.body);
  }

  // static Future<dynamic> getLatest(String mediaType) async {
  //   var finalUrl =
  //       url + '$mediaType/latest?api_key=$_ApiKey&language=en-US&page=1';
  //   var response = await _getResponse(finalUrl);
  //   return jsonDecode(response.body);
  // }

  static Future<dynamic> getTopRated(String mediaType, {int page}) async {
    var finalUrl = url +
        '$mediaType/top_rated?api_key=$_ApiKey&language=en-US&page=${page ?? 1}';
    var response = await _getResponse(finalUrl);
    return jsonDecode(response.body);
  }

  static Future<dynamic> getNowPlaying(String mediaType) async {
    var finalUrl =
        url + '$mediaType/now_playing?api_key=$_ApiKey&language=en-US&page=1';
    var response = await _getResponse(finalUrl);
    return jsonDecode(response.body);
  }
}
