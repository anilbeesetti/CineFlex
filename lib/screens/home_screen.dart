import 'package:cineflex/carousel.dart';
import 'package:cineflex/providers/data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movie_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum Tab {
  Movies,
  TvShows,
  MyList,
}

class _HomeScreenState extends State<HomeScreen> {
  Tab selectedTab = Tab.Movies;
  @override
  void initState() {
    context.read<DataProvider>().getPopularMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBar(),
            Container(
              height: 200,
              child: PageViewWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class PageViewWidget extends StatefulWidget {
  const PageViewWidget({
    Key key,
  }) : super(key: key);

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
    return PageView.builder(
      physics: ClampingScrollPhysics(),
      controller: _pageController,
      itemCount: context.watch<DataProvider>().popularMovies.length,
      itemBuilder: (context, index) {
        var movies = context.watch<DataProvider>().popularMovies;
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
    );
  }
}

class TopBar extends StatefulWidget {
  const TopBar({
    Key key,
  }) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  Tab selectedTab = Tab.Movies;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.search,
            size: 30,
          ),
          GestureDetector(
            child: Text(
              'Movies',
              style: TextStyle(
                  color: selectedTab == Tab.Movies
                      ? Colors.white
                      : Colors.blueGrey[500]),
            ),
            onTap: () {
              setState(() {
                selectedTab = Tab.Movies;
              });
            },
          ),
          GestureDetector(
            child: Text(
              'TV Shows',
              style: TextStyle(
                  color: selectedTab == Tab.TvShows
                      ? Colors.white
                      : Colors.blueGrey[500]),
            ),
            onTap: () {
              setState(() {
                selectedTab = Tab.TvShows;
              });
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => CarouselScreen(),
                  ));
            },
          ),
          GestureDetector(
            child: Text(
              'My List',
              style: TextStyle(
                  color: selectedTab == Tab.MyList
                      ? Colors.white
                      : Colors.blueGrey[500]),
            ),
            onTap: () {
              setState(() {
                selectedTab = Tab.MyList;
              });
            },
          ),
        ],
      ),
    );
  }
}
