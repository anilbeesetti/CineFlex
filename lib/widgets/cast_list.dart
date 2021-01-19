import 'dart:math';

import 'package:cineflex/screens/cast_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constansts.dart';
import 'cast_card.dart';

class CastList extends StatelessWidget {
  const CastList({
    Key key,
    this.cast,
    this.crew,
  }) : super(key: key);

  final List cast;
  final List crew;

  @override
  Widget build(BuildContext context) {
    return cast.length != 0
        ? Container(
            height: 200,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: min(9, cast.length),
              itemBuilder: (context, index) {
                if (cast.length > 9 && index == 8) {
                  return Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      child: Text(
                        'View More',
                        style: TextStyle(fontSize: 18, color: kAccentColor),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => CastScreen(
                                cast: cast,
                                crew: crew,
                              ),
                            ));
                      },
                    ),
                  );
                }
                return CastCard(
                  cast: cast[index],
                );
              },
            ),
          )
        : SizedBox.shrink();
  }
}
