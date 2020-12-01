import 'package:flutter/material.dart';

import '../constansts.dart';

class PosterInfo extends StatelessWidget {
  const PosterInfo({
    Key key,
    this.title,
    this.posterPath,
  }) : super(key: key);

  final String title;
  final String posterPath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                posterPath == '' || posterPath == null
                    ? 'https://www.seekpng.com/png/small/966-9665317_placeholder-image-person-jpg.png'
                    : 'https://image.tmdb.org/t/p/w780/$posterPath',
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
          bottom: 55,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              title,
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
    );
  }
}
