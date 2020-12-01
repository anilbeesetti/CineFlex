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

class Season {
  final int id;
  final int episodeCount;
  final String airDate;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;

  Season({
    this.episodeCount,
    this.airDate,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
  });
}

class Episode {
  final int id;
  final int episodeNumber;
  final String title;
  final String overview;
  final String airDate;
  final String stillPath;

  Episode({
    this.episodeNumber,
    this.id,
    this.title,
    this.overview,
    this.airDate,
    this.stillPath,
  });
}

class TvShowInfo {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final String orginalLanguage;
  final List genres;
  final List seasons;

  TvShowInfo({
    this.id,
    this.title,
    this.posterPath,
    this.backdropPath,
    this.overview,
    this.orginalLanguage,
    this.genres,
    this.seasons,
  });
}

// "air_date": "2019-11-12",
//       "episode_count": 8,
//       "id": 110346,
//       "name": "Season 1",
//       "overview": "A lone gunfighter makes his way through the outer reaches of the galaxy, far from the authority of the New Republic.",
//       "poster_path": "/sUTqIb82LxYhPT0SfI8AR03GLpz.jpg",
//       "season_number": 1
