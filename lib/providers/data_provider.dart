import 'package:cineflex/helpers/tmdb_api.dart';
import 'package:cineflex/models/cast_model.dart';
import 'package:cineflex/models/movie_model.dart';

import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  List<Movie> _popularMovies = [];
  List<Cast> _cast = [];
  List<Crew> _crew = [];
  String _director = '';
  String _writers = '';

  String get director => _director;
  String get writers => _writers;
  List<Movie> get popularMovies => _popularMovies;
  List<Cast> get cast => _cast;
  List<Crew> get crew => _crew;

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
    var responseData = await TmdbApi.getMovieCredits(id);
    _addCast(responseData);
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
          genreId: movie['genre_ids'],
          overview: movie['overview'],
          backdropPath: movie['backdrop_path'],
          orginalLanguage: movie['original_language'],
          posterPath: movie['poster_path'],
          releaseDate: movie['release_date'],
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
}

const string =
    'https://www.themoviedb.org/assets/2/v4/glyphicons/basic/glyphicons-basic-4-user-grey-d8fe957375e70239d6abdd549fd7568c89281b2179b5f4470e2e12895792dfa5.jpg';
