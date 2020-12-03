import 'package:cineflex/models/cast_model.dart';
import 'package:cineflex/models/movie_model.dart';
import 'package:cineflex/providers/data_provider.dart';
import 'package:cineflex/widgets/information_text.dart';
import 'package:cineflex/widgets/recommendations_list.dart';
import 'package:cineflex/widgets/title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CastDetailsScreen extends StatefulWidget {
  final cast;

  const CastDetailsScreen({Key key, this.cast}) : super(key: key);
  @override
  _CastDetailsScreenState createState() => _CastDetailsScreenState();
}

class _CastDetailsScreenState extends State<CastDetailsScreen> {
  bool isLoading = true;
  CastInfo _castInfo;
  List<Movie> _mediaList;
  @override
  void initState() {
    super.initState();
    getPersonInfo(widget.cast.id);
  }

  void getPersonInfo(int id) async {
    _castInfo = await context.read<DataProvider>().getPersonInfo(id);
    _mediaList = await context.read<DataProvider>().getKnownFor(id);
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.only(top: 20),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              bottom: 20,
                            ),
                            width: 200,
                            height: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                widget.cast.profilePath != null
                                    ? 'https://image.tmdb.org/t/p/w375_and_h375_face${widget.cast.profilePath}'
                                    : widget.cast.gender == 1
                                        ? 'https://t3.ftcdn.net/jpg/02/72/41/88/240_F_272418844_JlbSIQ5lPDdeEzYsbkd7rufTaXvN5CzE.jpg'
                                        : 'https://t3.ftcdn.net/jpg/02/39/31/82/240_F_239318209_LGYEQn78UEZCvliNtH1FrZTnkRvilPRx.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            widget.cast.name,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TitleText(
                            title: 'Personal Info',
                            padding: EdgeInsets.only(bottom: 5),
                          ),
                          InformationText(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            text: 'Known For : ',
                            subText: _castInfo.knownForDepartment,
                          ),
                          InformationText(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            text: 'Gender : ',
                            subText:
                                widget.cast.gender == 1 ? 'Female' : 'Male',
                          ),
                          InformationText(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            text: 'BirthDay : ',
                            subText: _castInfo.birthDay,
                          ),
                          if (_castInfo.deathDay != null)
                            InformationText(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              text: 'DeathDay : ',
                              subText: _castInfo.deathDay,
                            ),
                          InformationText(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            text: 'Place of Birth : ',
                            subText: _castInfo.placeOfBirth,
                          ),
                          TitleText(
                            title: 'Biography',
                            padding: EdgeInsets.only(bottom: 10, top: 20),
                          ),
                          Text(
                            _castInfo.biography,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.blueGrey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    TitleText(
                      title: 'Known For',
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    ),
                    RecommendationsList(recommendations: _mediaList)
                  ],
                ),
        ),
      ),
    );
  }
}
