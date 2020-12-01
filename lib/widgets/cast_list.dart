import 'dart:math';

import 'package:flutter/material.dart';

import '../constansts.dart';
import 'cast_card.dart';

class CastList extends StatelessWidget {
  const CastList({
    Key key,
    this.cast,
  }) : super(key: key);

  final List cast;

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
                var itemcount = cast.length;

                if (itemcount >= 9 && index == itemcount - 1) {
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
          )
        : SizedBox.shrink();
  }
}
