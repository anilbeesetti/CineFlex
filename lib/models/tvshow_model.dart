import 'package:cineflex/models/movie_model.dart';

class TvShow extends Movie {
  TvShow({
    int id,
    String title,
    String overview,
    String mediaType,
    String posterPath,
    String backdropPath,
    String orginalLanguage,
  }) : super(
          id: id,
          posterPath: posterPath,
          mediaType: mediaType,
          title: title,
          overview: overview,
          backdropPath: backdropPath,
          orginalLanguage: orginalLanguage,
        );
}

class TvShowInfo {
  int id;
  String title;
  String posterPath;
  String backdropPath;
  String overview;
  String orginalLanguage;
  List genres;
  String releaseDate;

  TvShowInfo({
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
