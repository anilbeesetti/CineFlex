import 'package:cineflex/helpers/tmdb_api.dart';
import 'package:cineflex/models/cast_model.dart';
import 'package:cineflex/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieProvider with ChangeNotifier {
  // Data
  List<Movie> _popularMovies = [];
  List<Movie> _topRatedMovies = [];
  List<Movie> _nowPlayingMovies = [];
  List<Movie> _upcomingMovies = [];
  List<Movie> _trendingMovies = [];

  // Getter Methods

  List<Movie> get trendingMovies => _trendingMovies;
  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get topRatedMovies => _topRatedMovies;
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;
  List<Movie> get upcomingMovies => _upcomingMovies;

  // Data get Methods
  Future<void> getTrendingMovies({int page}) async {
    var responseData = await TmdbApi.getData(DataType.trending, 'movie',
        page: page, timePeriod: 'week');
    _addMovies(responseData, _trendingMovies);
  }

  Future<void> getPopularMovies({int page}) async {
    var responseData =
        await TmdbApi.getData(DataType.popular, 'movie', page: page);
    _addMovies(responseData, _popularMovies);
  }

  Future<void> gettopRatedMovies({int page}) async {
    var responseData =
        await TmdbApi.getData(DataType.topRated, 'movie', page: page);
    _addMovies(responseData, _topRatedMovies);
  }

  Future<void> getNowPlayingMovies({int page}) async {
    var responseData =
        await TmdbApi.getData(DataType.nowPlaying, 'movie', page: page);
    _addMovies(responseData, _nowPlayingMovies);
  }

  Future<void> getUpcomingMovies({int page}) async {
    var responseData =
        await TmdbApi.getData(DataType.upcoming, 'movie', page: page);
    _addMovies(responseData, _upcomingMovies);
  }

  Future<void> getMovieInfo(
    int id,
    List mediaList,
    List<Cast> castList,
    List<Crew> crewList,
  ) async {
    await _getMovieCredits(id, castList, crewList);
    await _getRecommendations(id, mediaList);
    notifyListeners();
  }

  Future<void> _getMovieCredits(
      int id, List<Cast> castList, List<Crew> crewList) async {
    var responseData = await TmdbApi.getCredits(id, 'movie');
    _addCast(responseData, castList, crewList);
  }

  // Helper Medthods
  void _addMovies(responseData, List mediaList) {
    responseData['results'].forEach((movie) {
      mediaList.add(
        Movie(
          id: movie['id'],
          overview: movie['overview'],
          mediaType: 'movie',
          title: movie['original_title'],
          backdropPath: movie['backdrop_path'],
          orginalLanguage: movie['original_language'],
          posterPath: movie['poster_path'],
        ),
      );
    });
    notifyListeners();
  }

  void _addCast(responseData, List<Cast> castList, List<Crew> crewList) {
    responseData['cast'].forEach((cast) {
      castList.add(Cast(
          id: cast['id'],
          name: cast['name'],
          characterName: cast['character'],
          creditId: cast['credit_id'],
          profilePath: cast['profile_path'],
          gender: cast['gender']));
    });
    responseData['crew'].forEach((crew) {
      crewList.add(Crew(
          id: crew['id'],
          name: crew['name'],
          profilePath: crew['profile_path'],
          department: crew['department'],
          creditId: crew['credit_id'],
          job: crew['job'],
          gender: crew['gender']));
    });
  }

  String setGenres(List genresDataList) {
    var genresList = [];
    for (var i = 0; i < genresDataList.length; i++) {
      genresList.add(genresDataList[i]['name']);
    }
    return genresList.join(', ');
  }

  Future<MovieInfo> getMovieDetails(int id) async {
    var responseData = await TmdbApi.getMediaData(id, 'movie');
    return MovieInfo(
      id: responseData['id'],
      orginalLanguage: responseData['original_language'],
      genres: responseData['genres'],
      title: responseData['original_title'],
      releaseDate: responseData['release_date'],
    );
  }

  Future<void> _getRecommendations(int id, List mediaList) async {
    var responseData = await TmdbApi.getRecommendations(id, 'movie');
    _addMovies(responseData, mediaList);
    notifyListeners();
  }
}
