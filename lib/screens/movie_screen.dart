import 'dart:math';

import 'package:cineflex/constansts.dart';
import 'package:cineflex/models/movie_model.dart';
import 'package:cineflex/providers/movie_provider.dart';
import 'package:cineflex/widgets/cast_card.dart';
import 'package:cineflex/widgets/information_text.dart';
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
  @override
  void initState() {
    context.read<MovieProvider>().getMovieInfo(widget.movie.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var movie = context.watch<MovieProvider>().movieInfo;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Hero(
                  tag: widget.movie.id,
                  child: Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          widget.movie.posterPath == '' ||
                                  widget.movie.posterPath == null
                              ? 'https://www.seekpng.com/png/small/966-9665317_placeholder-image-person-jpg.png'
                              : 'https://image.tmdb.org/t/p/w780/${widget.movie.posterPath}',
                        ),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            kPrimaryColor,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 55,
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      widget.movie.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 5,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: kAccentColor,
                    child: Icon(
                      Icons.play_arrow_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            TitleText(
              title: 'The Plot',
              padding: EdgeInsets.only(right: 20, bottom: 10, left: 20, top: 5),
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
              subText: context.watch<MovieProvider>().director,
            ),
            InformationText(
              text: 'Writers : ',
              subText: context.watch<MovieProvider>().writers,
            ),
            TitleText(
              title: 'The Cast',
            ),
            Container(
              height: 200,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount:
                    min(9, context.watch<MovieProvider>().cast.length + 1),
                itemBuilder: (context, index) {
                  var itemcount =
                      min(9, context.watch<MovieProvider>().cast.length + 1);
                  var cast = context.watch<MovieProvider>().cast;
                  if (index == itemcount - 1) {
                    return Container(
                      alignment: Alignment.center,
                      child: FlatButton(
                        child: Text(
                          'View More',
                          style: TextStyle(fontSize: 18, color: kAccentColor),
                        ),
                        onPressed: () {},
                      ),
                    );
                  }
                  return CastCard(
                    cast: cast[index],
                  );
                },
              ),
            ),
            TitleText(title: 'More Details'),
            InformationText(
              text: 'Genres : ',
              subText: context.watch<MovieProvider>().genres,
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
            RecommendationsList()
          ],
        ),
      ),
    );
  }
}

class RecommendationsList extends StatelessWidget {
  const RecommendationsList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        itemCount: context.watch<MovieProvider>().recommendations.length,
        itemBuilder: (context, index) {
          var recommendations = context.watch<MovieProvider>().recommendations;
          return GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => MovieScreen(
                      movie: recommendations[index],
                    ),
                  ));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  margin: EdgeInsets.only(right: 20, bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      recommendations[index].backdropPath == null
                          ? 'https://www.seekpng.com/png/small/966-9665317_placeholder-image-person-jpg.png'
                          : 'https://image.tmdb.org/t/p/w500/${recommendations[index].backdropPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 250,
                  child: Text(
                    recommendations[index].title,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
