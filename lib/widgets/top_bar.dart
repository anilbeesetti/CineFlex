import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key key,
    @required this.selectedTab,
    @required this.setTab,
  }) : super(key: key);

  final MenuTab selectedTab;
  final Function setTab;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Icon(
              Icons.home_outlined,
              size: 30,
            ),
            onTap: () {
              setTab(MenuTab.Home);
            },
          ),
          GestureDetector(
            child: Text(
              'Movies',
              style: TextStyle(
                  color: selectedTab == MenuTab.Movies
                      ? Colors.white
                      : Colors.blueGrey[500]),
            ),
            onTap: () {
              setTab(MenuTab.Movies);
            },
          ),
          GestureDetector(
            child: Text(
              'TV Shows',
              style: TextStyle(
                  color: selectedTab == MenuTab.TvShows
                      ? Colors.white
                      : Colors.blueGrey[500]),
            ),
            onTap: () {
              setTab(MenuTab.TvShows);
            },
          ),
          GestureDetector(
            child: Text(
              'My List',
              style: TextStyle(
                  color: selectedTab == MenuTab.MyList
                      ? Colors.white
                      : Colors.blueGrey[500]),
            ),
            onTap: () {
              setTab(MenuTab.MyList);
            },
          ),
        ],
      ),
    );
  }
}
