import 'package:flutter/foundation.dart';

class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String orginalLanguage;

  Movie({
    @required this.id,
    @required this.title,
    @required this.overview,
    @required this.posterPath,
    @required this.backdropPath,
    @required this.orginalLanguage,
  });
}

class MovieInfo {
  int id;
  String title;
  String posterPath;
  String backdropPath;
  String overview;
  String orginalLanguage;
  List genres;
  String releaseDate;

  MovieInfo({
    this.id = 0,
    this.title = '',
    this.posterPath = '',
    this.overview = '',
    this.backdropPath = '',
    this.orginalLanguage = '',
    this.genres = const [],
    this.releaseDate = '',
  });
}
