import 'package:cineflex/screens/movie_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageViewWidget extends StatefulWidget {
  const PageViewWidget({
    Key key,
    @required this.collection,
    this.height,
  }) : super(key: key);
  final List collection;
  final double height;

  @override
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  PageController _pageController;
  double viewPortFraction = 0.85;
  double pageOffset = 0;

  @override
  void initState() {
    _pageController =
        PageController(initialPage: 0, viewportFraction: viewPortFraction)
          ..addListener(() {
            setState(() {
              pageOffset = _pageController.page;
            });
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var distortionValue = 1.0;
    return Container(
      height: widget.height,
      child: PageView.builder(
        physics: ClampingScrollPhysics(),
        controller: _pageController,
        itemCount: widget.collection.length,
        itemBuilder: (context, index) {
          var movies = widget.collection;
          final distortionRatio =
              (1 - ((pageOffset - index).abs() * 0.3)).clamp(0.0, 1.0);
          distortionValue = Curves.easeOut.transform(distortionRatio);

          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => MovieScreen(
                      movie: movies[index],
                    ),
                  ));
            },
            child: Transform.scale(
              // padding: EdgeInsets.only(
              //   top: 100 - scale * 50,
              //   right: 8,
              //   left: 8,
              //   bottom: 100 - scale * 50,
              // ),
              scale: distortionValue,
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500/${movies[index].backdropPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Container(
                      width: 200,
                      child: Text(
                        movies[index].title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
