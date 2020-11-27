class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String orginalLanguage;

  Movie({
    this.id,
    this.title,
    this.posterPath,
    this.backdropPath,
    this.orginalLanguage,
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
