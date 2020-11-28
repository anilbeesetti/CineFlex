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
            child: Hero(
              tag: media[index].id,
              child: Container(
                margin: EdgeInsets.only(right: 15),
                height: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w300/${media[index].posterPath}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
