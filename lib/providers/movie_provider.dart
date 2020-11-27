import 'package:cineflex/helpers/data_helper.dart';
import 'package:cineflex/helpers/tmdb_api.dart';
import 'package:cineflex/models/cast_model.dart';
import 'package:cineflex/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _popularMovies = [];
  List<Cast> _cast = [];
  List<Crew> _crew = [];
  List<Movie> _recommendations = [];
  String _director = '';
  String _writers = '';
  String _genres = '';
  MovieInfo _movieInfo = MovieInfo();

  String get director => _director;
  String get writers => _writers;
  String get genres => _genres;
  List<Movie> get popularMovies => _popularMovies;
  List<Cast> get cast => _cast;
  List<Crew> get crew => _crew;
  List<Movie> get recommendations => _recommendations;
  MovieInfo get movieInfo => _movieInfo;

  void _setGenres() {
    var genresList = [];
    for (var i = 0; i < movieInfo.genres.length; i++) {
      genresList.add(movieInfo.genres[i]['name']);
    }
    _genres = genresList.join(', ');
  }

  void getPopularMovies() async {
    var responseData = await TmdbApi.getPopularMoives();
    _addMovies(responseData);
  }

  void _addMovies(responseData) {
    responseData['results'].forEach((movie) {
      _popularMovies.add(
        Movie(
          id: movie['id'],
          overview: movie['overview'],
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
    _setGenres();
    notifyListeners();
  }

  void _getRecommendations(int id) async {
    var responseData = await TmdbApi.getRecommendations(id);
    responseData['results'].forEach((movie) {
      _recommendations.add(
        Movie(
          id: movie['id'],
          overview: movie['overview'],
          title: movie['original_title'],
          backdropPath: movie['backdrop_path'],
          orginalLanguage: movie['original_language'],
          posterPath: movie['poster_path'],
        ),
      );
    });
    notifyListeners();
  }

  void getMovieInfo(int id) async {
    _cast = [];
    _crew = [];
    _director = '';
    _writers = '';
    _movieInfo = MovieInfo();
    _recommendations = [];
    var responseData = await TmdbApi.getMovieCredits(id);
    _addCast(responseData);
    _getMovieDetails(id);
    _getRecommendations(id);
    _director = DataHelper.setDirector(crew);
    _writers = DataHelper.setWriters(crew);
    notifyListeners();
  }
}
