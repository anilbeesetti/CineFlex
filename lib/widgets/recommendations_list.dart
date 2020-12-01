import 'package:cineflex/screens/movie_screen.dart';
import 'package:cineflex/screens/tv_show_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecommendationsList extends StatelessWidget {
  const RecommendationsList({
    Key key,
    @required this.recommendations,
  }) : super(key: key);

  final List recommendations;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (recommendations[index].mediaType == 'movie') {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => MovieScreen(
                      movie: recommendations[index],
                    ),
                  ),
                );
              } else if (recommendations[index].mediaType == 'tv') {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => TvShowScreen(
                      tvShow: recommendations[index],
                    ),
                  ),
                );
              }
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
                    recommendations[index].title ?? '',
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
