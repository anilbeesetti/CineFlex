import 'package:cineflex/helpers/data_helper.dart';
import 'package:cineflex/models/cast_model.dart';
import 'package:cineflex/models/tvshow_model.dart';
import 'package:cineflex/providers/tvshow_provider.dart';

import 'package:cineflex/widgets/cast_list.dart';
import 'package:cineflex/widgets/episodes_listview.dart';
import 'package:cineflex/widgets/information_text.dart';
import 'package:cineflex/widgets/poster_info.dart';
import 'package:cineflex/widgets/recommendations_list.dart';
import 'package:cineflex/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constansts.dart';

class TvShowScreen extends StatefulWidget {
  final TvShow tvShow;

  const TvShowScreen({Key key, this.tvShow}) : super(key: key);

  @override
  _TvShowScreenState createState() => _TvShowScreenState();
}

class _TvShowScreenState extends State<TvShowScreen> {
  int selectedSeason = 1;
  bool isEpisodeLoading = false;
  bool isLoading = true;
  List<Cast> cast = [];
  List<Crew> crew = [];
  List recommendations = [];
  List<Episode> episodeList = [];
  String director = '';
  String writers = '';
  TvShowInfo tvShowInfo;
  String genres = '';

  @override
  void initState() {
    super.initState();
    getTvShowInfo();
  }

  void getTvShowInfo() async {
    var tvShowProvider = context.read<TvShowProvider>();
    await tvShowProvider.getSeasonInfo(
        widget.tvShow.id, selectedSeason, episodeList);
    await tvShowProvider.getTvShowCredits(widget.tvShow.id, cast, crew);
    await tvShowProvider.getRecommendations(widget.tvShow.id, recommendations);
    tvShowInfo = await tvShowProvider.getTvShowDetails(widget.tvShow.id);
    director = DataHelper.setDirector(crew);
    writers = DataHelper.setWriters(crew);
    setState(() {
      isLoading = false;
    });
  }

  // void getMovieInfo() async {
  //   var movieProvider = context.read<MovieProvider>();
  //   await movieProvider.getMovieInfo(
  //       widget.movie.id, recommendations, cast, crew);
  //   movieInfo = await movieProvider.getMovieDetails(widget.movie.id);
  //   genres = movieProvider.setGenres(movieInfo.genres);
  //   director = DataHelper.setDirector(crew);
  //   writers = DataHelper.setWriters(crew);
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var tvShow = tvShowInfo;
    return Scaffold(
      body: SingleChildScrollView(
        child: isLoading
            ? Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PosterInfo(
                    title: widget.tvShow.title,
                    posterPath: widget.tvShow.posterPath,
                  ),
                  TitleText(
                    title: 'The Plot',
                    padding: EdgeInsets.only(
                        right: 20, bottom: 10, left: 20, top: 5),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Text(
                      widget.tvShow.overview,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blueGrey[500],
                      ),
                    ),
                  ),
                  InformationText(
                    text: 'Director : ',
                    subText: director,
                  ),
                  InformationText(
                    text: 'Writers : ',
                    subText: writers,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: tvShow.seasons == null
                        ? SizedBox.shrink()
                        : DropdownButtonFormField(
                            value: selectedSeason,
                            dropdownColor: kAccentColor,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            onChanged: (value) async {
                              setState(() {
                                isEpisodeLoading = true;
                              });
                              episodeList = [];
                              await context
                                  .read<TvShowProvider>()
                                  .getSeasonInfo(
                                      widget.tvShow.id, value, episodeList);
                              setState(() {
                                selectedSeason = value;
                                isEpisodeLoading = false;
                              });
                            },
                            items: tvShow.seasons
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e['season_number'],
                                    child: Text(e['name']),
                                  ),
                                )
                                .toList(),
                          ),
                  ),
                  isEpisodeLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : EpisodeList(episodes: episodeList),
                  SizedBox(
                    height: 10,
                  ),
                  cast.length != 0
                      ? TitleText(
                          title: 'The Cast',
                        )
                      : SizedBox.shrink(),
                  CastList(
                    cast: cast,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TitleText(title: 'Recommendations'),
                  RecommendationsList(
                    recommendations: recommendations,
                  )
                ],
              ),
      ),
    );
  }
}
