import 'package:flutter/foundation.dart';

class Movie {
  final int id;
  final String title;
  final String overview;
  final String mediaType;
  final String posterPath;
  final String backdropPath;
  final String orginalLanguage;

  Movie({
    @required this.id,
    @required this.title,
    @required this.overview,
    @required this.mediaType,
    @required this.posterPath,
    @required this.backdropPath,
    @required this.orginalLanguage,
  });
}

class MovieInfo {
  int id;
  String title;
  String orginalLanguage;
  List genres;
  String releaseDate;

  MovieInfo({
    this.id = 0,
    this.title = '',
    this.orginalLanguage = '',
    this.genres = const [],
    this.releaseDate = '',
  });
}
