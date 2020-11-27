import 'package:cineflex/helpers/tmdb_api.dart';
import 'package:cineflex/models/cast_model.dart';
import 'package:cineflex/models/movie_model.dart';

import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  List<Movie> _popularMovies = [];
  List<Cast> _cast = [];
  List<Crew> _crew = [];
  List<Movie> _recommendations = [];
  String _director = '';
  String _writers = '';
  MovieInfo _movieInfo = MovieInfo();

  String get director => _director;
  String get writers => _writers;
  List<Movie> get popularMovies => _popularMovies;
  List<Cast> get cast => _cast;
  List<Crew> get crew => _crew;
  MovieInfo get movieInfo => _movieInfo;
  List<Movie> get recommendations => _recommendations;

  void _setDirector() {
    var crew = _crew.firstWhere((element) => element.job == 'Director');
    _director = crew.name;
  }

  void _setWriters() {
    var crew =
        _crew.where((element) => element.department == 'Writing').toList();
    var crewNames = [];
    for (var i = 0; i < crew.length; i++) {
      crewNames.add(crew[i].name);
    }
    _writers = crewNames.join(", ");
  }

  void getPopularMovies() async {
    var responseData = await TmdbApi.getPopularMoives();
    _addMovies(responseData);
  }

  void getMovieInfo(int id) async {
    _cast = [];
    _crew = [];
    _movieInfo = MovieInfo();
    _recommendations = [];
    var responseData = await TmdbApi.getMovieCredits(id);
    _addCast(responseData);
    _getMovieDetails(id);
    _getRecommendations(id);
    _setDirector();
    _setWriters();
    notifyListeners();
  }

  void _addMovies(responseData) {
    responseData['results'].forEach((movie) {
      _popularMovies.add(
        Movie(
          id: movie['id'],
          title: movie['original_title'],
          backdropPath: movie['backdrop_path'],
          orginalLanguage: movie['original_language'],
          posterPath: movie['poster_path'],
        ),
      );
    });
    notifyListeners();
  }

  void _addCast(responseData) {
    responseData['cast'].forEach((cast) {
      _cast.add(Cast(
          id: cast['id'],
          name: cast['name'],
          characterName: cast['character'],
          creditId: cast['credit_id'],
          profilePath: cast['profile_path']));
    });
    responseData['crew'].forEach((crew) {
      _crew.add(Crew(
        id: crew['id'],
        name: crew['name'],
        profilePath: crew['profile_path'],
        department: crew['department'],
        creditId: crew['credit_id'],
        job: crew['job'],
      ));
    });
  }

  void _getMovieDetails(int id) async {
    var responseData = await TmdbApi.getMovie(id);
    _movieInfo.id = responseData['id'];
    _movieInfo.backdropPath = responseData['backdrop_path'];
    _movieInfo.orginalLanguage = responseData['original_language'];
    _movieInfo.genres = responseData['genres'];
    _movieInfo.posterPath = responseData['poster_path'];
    _movieInfo.title = responseData['original_title'];
    _movieInfo.releaseDate = responseData['release_date'];
    _movieInfo.overview = responseData['overview'];
    notifyListeners();
  }

  void _getRecommendations(int id) async {
    var responseData = await TmdbApi.getRecommendations(id);
    responseData['results'].forEach((movie) {
      _recommendations.add(
        Movie(
          id: movie['id'],
          title: movie['original_title'],
          backdropPath: movie['backdrop_path'],
          orginalLanguage: movie['original_language'],
          posterPath: movie['poster_path'],
        ),
      );
    });
    notifyListeners();
  }
}
