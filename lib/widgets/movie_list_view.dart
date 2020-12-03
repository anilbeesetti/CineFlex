import 'dart:math';

import 'package:cineflex/screens/movie_screen.dart';
import 'package:cineflex/screens/tv_show_screen.dart';
import 'package:flutter/material.dart';

class MovieListView extends StatelessWidget {
  const MovieListView({
    Key key,
    @required this.media,
  }) : super(key: key);

  final List media;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 20, right: 10),
        scrollDirection: Axis.horizontal,
        itemCount: min(20, media.length),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (media[index].mediaType == 'movie') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieScreen(
                      movie: media[index],
                    ),
                  ),
                );
              } else if (media[index].mediaType == 'tv') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TvShowScreen(
                      tvShow: media[index],
                    ),
                  ),
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[700],
                borderRadius: BorderRadius.circular(8),
              ),
              margin: EdgeInsets.only(right: 15),
              height: 160,
              width: 108,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  media[index].posterPath == null ||
                          media[index].posterPath == ''
                      ? 'https://www.ghnapp.com/img/movie-placeholder.gif'
                      : 'https://image.tmdb.org/t/p/w300/${media[index].posterPath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
