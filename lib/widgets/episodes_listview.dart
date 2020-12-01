import 'package:cineflex/models/tvshow_model.dart';
import 'package:flutter/material.dart';

import '../constansts.dart';

class EpisodeList extends StatelessWidget {
  const EpisodeList({
    Key key,
    @required this.episodes,
  }) : super(key: key);

  final List<Episode> episodes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: episodes
          .map((e) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 5,
                ),
                child: ExpansionTile(
                  backgroundColor: kSecondaryColor,
                  collapsedBackgroundColor: kSecondaryColor,
                  tilePadding: EdgeInsets.only(left: 20, right: 20),
                  childrenPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  title: Text('Episode ${e.episodeNumber}'),
                  subtitle: Text(
                    e.title,
                    maxLines: 2,
                    style: TextStyle(color: Colors.blueGrey[400]),
                  ),
                  trailing: CircleAvatar(
                    radius: 20,
                    backgroundColor: kAccentColor,
                    child: Icon(
                      Icons.play_arrow_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  children: [
                    Text(e.overview),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [Text(e.airDate)],
                    )
                  ],
                ),
              ))
          .toList(),
    );
  }
}
