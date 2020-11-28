import 'package:cineflex/helpers/tmdb_api.dart';
import 'package:cineflex/models/tvshow_model.dart';
import 'package:flutter/foundation.dart';

class TvShowProvider with ChangeNotifier {
  List<TvShow> _popularTvShows = [];
  List<TvShow> _topRatedTvShows = [];
  List<TvShow> _recommendations = [];
  String _director = '';
  String _writers = '';
  String _genres = '';
  TvShowInfo _tvShowInfo = TvShowInfo();

  String get director => _director;
  String get writers => _writers;
  String get genres => _genres;
  List<TvShow> get popularTvShows => _popularTvShows;
  List<TvShow> get topRatedTvShows => _topRatedTvShows;
  List<TvShow> get recommendations => _recommendations;
  TvShowInfo get tvShowInfo => _tvShowInfo;

  void getPopularTvShows() async {
    var responseData = await TmdbApi.getPopularTvShows();
    _addTvShow(responseData, _popularTvShows);
  }

  void getTopRatedTvShows() async {
    var responseData = await TmdbApi.getTopRated('tv');
    _addTvShow(responseData, _topRatedTvShows);
  }

  void _addTvShow(responseData, List mediaList) {
    responseData['results'].forEach((media) {
      mediaList.add(
        TvShow(
          id: media['id'],
          overview: media['overview'],
          mediaType: 'tv',
          title: media['original_name'],
          backdropPath: media['backdrop_path'],
          orginalLanguage: media['original_language'],
          posterPath: media['poster_path'],
        ),
      );
    });
    notifyListeners();
  }
}
