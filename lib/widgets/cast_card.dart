import 'package:cineflex/models/cast_model.dart';
import 'package:cineflex/screens/cast_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CastCard extends StatelessWidget {
  const CastCard({
    Key key,
    @required this.cast,
  }) : super(key: key);

  final Cast cast;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => CastDetailsScreen(
                cast: cast,
              ),
            ));
      },
      child: Card(
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
                      : cast.gender == 1
                          ? 'https://t3.ftcdn.net/jpg/02/72/41/88/240_F_272418844_JlbSIQ5lPDdeEzYsbkd7rufTaXvN5CzE.jpg'
                          : 'https://t3.ftcdn.net/jpg/02/39/31/82/240_F_239318209_LGYEQn78UEZCvliNtH1FrZTnkRvilPRx.jpg',
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
      ),
    );
  }
}
