import 'package:cineflex/helpers/tmdb_api.dart';
import 'package:cineflex/models/cast_model.dart';
import 'package:cineflex/models/tvshow_model.dart';
import 'package:flutter/foundation.dart';

class TvShowProvider with ChangeNotifier {
  List<TvShow> _popularTvShows = [];
  List<TvShow> _topRatedTvShows = [];
  List<TvShow> _trendingTvShows = [];
  List<TvShow> _onTheAirTvShows = [];

  List<Season> _seasonList;

  List<TvShow> get trendingTvShows => _trendingTvShows;
  List<TvShow> get popularTvShows => _popularTvShows;
  List<TvShow> get topRatedTvShows => _topRatedTvShows;
  List<TvShow> get onTheAirTvShows => _onTheAirTvShows;

  List<Season> get seasonList => _seasonList;

  void resetPopularTvShows() {
    _popularTvShows = [];
  }

  void resetTopRatedTvShows() {
    _topRatedTvShows = [];
  }

  void resetTrendingTvShows() {
    _trendingTvShows = [];
  }

  void resetOntheAirTvShows() {
    _onTheAirTvShows = [];
  }

  Future<void> getTrendingTvShows({int page}) async {
    var responseData = await TmdbApi.getData(DataType.trending, 'tv');
    _addTvShow(responseData, _trendingTvShows);
  }

  Future<void> getPopularTvShows({int page}) async {
    var responseData =
        await TmdbApi.getData(DataType.popular, 'tv', page: page);

    _addTvShow(responseData, _popularTvShows);
  }

  Future<void> getTopRatedTvShows({int page}) async {
    var responseData =
        await TmdbApi.getData(DataType.topRated, 'tv', page: page);
    _addTvShow(responseData, _topRatedTvShows);
  }

  Future<void> getOnTheAirTvShows({int page}) async {
    var responseData =
        await TmdbApi.getData(DataType.onTheAir, 'tv', page: page);
    _addTvShow(responseData, _onTheAirTvShows);
  }

  Future<TvShowInfo> getTvShowDetails(int id) async {
    var responseData = await TmdbApi.getMediaData(id, 'tv');
    return TvShowInfo(
      id: responseData['id'],
      backdropPath: responseData['backdrop_path'],
      orginalLanguage: responseData['original_language'],
      genres: responseData['genres'],
      posterPath: responseData['poster_path'],
      title: responseData['original_name'],
      overview: responseData['overview'],
      seasons: responseData['seasons'],
    );
    // await getSeasonInfo(id, 1);
    // await _getRecommendations(id);
    // _director = DataHelper.setDirector(crew);
    // _writers = DataHelper.setWriters(crew);
    // notifyListeners();
  }

  Future<void> getSeasonInfo(
      int tvId, int seasonNumber, List episodeList) async {
    await _getEpisodes(tvId, seasonNumber, episodeList);
    notifyListeners();
  }

  Future<void> _getEpisodes(
      int tvId, int seasonNumber, List episodeList) async {
    var responseData = await TmdbApi.getSeasonInfo(tvId, seasonNumber);
    responseData['episodes'].forEach((episode) {
      episodeList.add(
        Episode(
          id: episode['id'],
          title: episode['name'],
          airDate: episode['air_date'],
          overview: episode['overview'],
          stillPath: episode['still_path'],
          episodeNumber: episode['episode_number'],
        ),
      );
    });
  }

  Future<void> getTvShowCredits(
    int id,
    List<Cast> castList,
    List<Crew> crewList,
  ) async {
    var responseData = await TmdbApi.getCredits(id, 'tv');
    _addCast(responseData, castList, crewList);
  }

  void _addCast(responseData, List<Cast> castList, List<Crew> crewList) {
    responseData['cast'].forEach((cast) {
      castList.add(Cast(
          id: cast['id'],
          name: cast['name'],
          characterName: cast['character'],
          creditId: cast['credit_id'],
          profilePath: cast['profile_path'],
          gender: cast['gender']));
    });
    responseData['crew'].forEach((crew) {
      crewList.add(Crew(
          id: crew['id'],
          name: crew['name'],
          profilePath: crew['profile_path'],
          department: crew['department'],
          creditId: crew['credit_id'],
          job: crew['job'],
          gender: crew['gender']));
    });
  }

  // Future<void> getTvShowInfo(int id, List mediaList, List<Cast> castList, List<Crew> crewList) async {
  //   await _getTvShowCredits(tvId, seasonNumber)
  //   notifyListeners();
  // }

  // Future<void> getMovieInfo(
  //   int id,
  //   List mediaList,
  //   List<Cast> castList,
  //   List<Crew> crewList,
  // ) async {
  //   await _getMovieCredits(id, castList, crewList);
  //   await _getRecommendations(id, mediaList);
  //   notifyListeners();
  // }

  Future<void> getRecommendations(int id, List mediaList) async {
    var responseData = await TmdbApi.getRecommendations(id, 'tv');
    _addTvShow(responseData, mediaList);
    notifyListeners();
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
