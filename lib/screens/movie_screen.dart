import 'package:cineflex/helpers/data_helper.dart';
import 'package:cineflex/models/cast_model.dart';
import 'package:cineflex/models/movie_model.dart';
import 'package:cineflex/providers/movie_provider.dart';

import 'package:cineflex/widgets/cast_list.dart';
import 'package:cineflex/widgets/information_text.dart';
import 'package:cineflex/widgets/poster_info.dart';
import 'package:cineflex/widgets/recommendations_list.dart';
import 'package:cineflex/widgets/title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieScreen extends StatefulWidget {
  final Movie movie;

  const MovieScreen({Key key, @required this.movie}) : super(key: key);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  bool isLoading = true;
  List<Cast> cast = [];
  List<Crew> crew = [];
  List recommendations = [];
  String director = '';
  String writers = '';
  MovieInfo movieInfo;
  String genres = '';

  @override
  void initState() {
    super.initState();
    getMovieInfo();
  }

  void getMovieInfo() async {
    var movieProvider = context.read<MovieProvider>();
    await movieProvider.getMovieInfo(
        widget.movie.id, recommendations, cast, crew);
    movieInfo = await movieProvider.getMovieDetails(widget.movie.id);
    genres = movieProvider.setGenres(movieInfo.genres);
    director = DataHelper.setDirector(crew);
    writers = DataHelper.setWriters(crew);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var movie = movieInfo;
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
                    title: widget.movie.title,
                    posterPath: widget.movie.posterPath,
                  ),
                  TitleText(
                    title: 'The Plot',
                    padding: EdgeInsets.only(
                        right: 20, bottom: 10, left: 20, top: 5),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Text(
                      widget.movie.overview,
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
                  TitleText(title: 'More Details'),
                  InformationText(
                    text: 'Genres : ',
                    subText: genres,
                  ),
                  InformationText(
                    text: 'Release Date : ',
                    subText: movie.releaseDate,
                  ),
                  InformationText(
                    text: 'Language : ',
                    subText: movie.orginalLanguage == 'en'
                        ? 'English'
                        : movie.orginalLanguage,
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
