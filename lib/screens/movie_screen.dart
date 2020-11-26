import 'dart:math';

import 'package:cineflex/constansts.dart';
import 'package:cineflex/models/cast_model.dart';
import 'package:cineflex/models/movie_model.dart';
import 'package:cineflex/providers/data_provider.dart';
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
    context.read<DataProvider>().getMovieInfo(widget.movie.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w780/${widget.movie.posterPath}',
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
                Positioned(
                  bottom: 50,
                  child: Row(
                    children: [
                      Text(
                        widget.movie.title,
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 10,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(right: 20, bottom: 10, left: 20, top: 4),
                  child: Text(
                    'The Plot',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        fontFamily: 'Lato'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.movie.overview,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blueGrey[500],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blueGrey[500],
                      ),
                      children: [
                        TextSpan(
                          text: 'Director : ',
                          style: TextStyle(
                            color: kAccentColor,
                          ),
                        ),
                        TextSpan(text: context.watch<DataProvider>().director)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blueGrey[500],
                      ),
                      children: [
                        TextSpan(
                          text: 'Writers : ',
                          style: TextStyle(
                            color: kAccentColor,
                          ),
                        ),
                        TextSpan(text: context.watch<DataProvider>().writers)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    'The Cast',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        min(9, context.watch<DataProvider>().cast.length + 1),
                    itemBuilder: (context, index) {
                      var itemcount =
                          min(9, context.watch<DataProvider>().cast.length + 1);
                      var cast = context.watch<DataProvider>().cast;
                      if (index == itemcount - 1) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'View More',
                              style:
                                  TextStyle(fontSize: 18, color: kAccentColor),
                            ),
                          ),
                        );
                      }
                      return CastCard(cast: cast[index]);
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CastCard extends StatelessWidget {
  const CastCard({
    Key key,
    @required this.cast,
  }) : super(key: key);

  final Cast cast;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: 12),
      color: Colors.blueGrey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                cast.profilePath != null
                    ? 'https://image.tmdb.org/t/p/w375_and_h375_face${cast.profilePath}'
                    : 'https://www.seekpng.com/png/small/966-9665317_placeholder-image-person-jpg.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 110,
            padding:
                const EdgeInsets.only(top: 8, bottom: 4, left: 8, right: 8),
            child: Text(
              cast.name,
              softWrap: true,
              style: TextStyle(fontSize: 13),
            ),
          ),
          Container(
            width: 110,
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text(
              cast.characterName,
              maxLines: 2,
              style: TextStyle(
                fontSize: 13,
                color: Colors.blueGrey[500],
              ),
            ),
          )
        ],
      ),
    );
  }
}
