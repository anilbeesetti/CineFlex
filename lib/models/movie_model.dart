class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String orginalLanguage;
  final String overview;
  final String releaseDate;
  final List genreId;

  Movie({
    this.id,
    this.title,
    this.posterPath,
    this.backdropPath,
    this.orginalLanguage,
    this.overview,
    this.releaseDate,
    this.genreId,
  });
}

class MovieInfo {}
