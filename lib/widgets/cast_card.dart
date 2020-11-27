import 'package:cineflex/models/cast_model.dart';
import 'package:flutter/material.dart';

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
