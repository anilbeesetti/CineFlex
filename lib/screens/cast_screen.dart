import 'package:cineflex/constansts.dart';
import 'package:cineflex/models/cast_model.dart';
import 'package:cineflex/screens/cast_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CastScreen extends StatelessWidget {
  final List<Cast> cast;
  final List<Crew> crew;

  const CastScreen({Key key, this.cast, this.crew}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 10, left: 20, right: 20),
                child: CastTitleText(
                  title: 'Cast',
                  subTitle: cast.length.toString(),
                ),
              ),
              ...cast.map(
                (cast) => CastScreenCard(
                  key: ValueKey(cast.creditId),
                  profilePath: cast.profilePath,
                  name: cast.name,
                  subtitle: cast.characterName,
                  gender: cast.gender,
                  onPress: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CastDetailsScreen(
                            cast: cast,
                          ),
                        ));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 10, left: 20, right: 20),
                child: CastTitleText(
                  title: 'Crew',
                  subTitle: crew.length.toString(),
                ),
              ),
              ...crew.map((crew) => CastScreenCard(
                    key: ValueKey(crew.creditId),
                    name: crew.name,
                    profilePath: crew.profilePath,
                    subtitle: crew.job,
                    onPress: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => CastDetailsScreen(
                              cast: crew,
                            ),
                          ));
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class CastScreenCard extends StatelessWidget {
  const CastScreenCard({
    Key key,
    this.profilePath,
    this.onPress,
    this.name,
    this.subtitle,
    this.gender,
  }) : super(key: key);

  final String profilePath;
  final int gender;
  final String name;
  final String subtitle;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        width: double.infinity,
        height: 90,
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                profilePath != null
                    ? 'https://image.tmdb.org/t/p/w375_and_h375_face$profilePath'
                    : gender == 1
                        ? 'https://t3.ftcdn.net/jpg/02/72/41/88/240_F_272418844_JlbSIQ5lPDdeEzYsbkd7rufTaXvN5CzE.jpg'
                        : 'https://t3.ftcdn.net/jpg/02/39/31/82/240_F_239318209_LGYEQn78UEZCvliNtH1FrZTnkRvilPRx.jpg',
                fit: BoxFit.cover,
                width: 80,
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    subtitle,
                    textWidthBasis: TextWidthBasis.parent,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.blueGrey[400],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CastTitleText extends StatelessWidget {
  const CastTitleText({
    Key key,
    this.title,
    this.subTitle,
  }) : super(key: key);

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          subTitle,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 20,
          ),
        )
      ],
    );
  }
}
