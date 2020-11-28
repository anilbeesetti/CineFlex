import 'package:flutter/material.dart';

import '../constansts.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    Key key,
    @required this.selectedTab,
    this.selectTab,
  }) : super(key: key);

  final MenuTab selectedTab;
  final Function selectTab;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      backgroundColor: kPrimaryColor,
      leading: IconButton(
        icon: Icon(Icons.home_outlined),
        onPressed: () {
          selectTab(MenuTab.Home);
        },
      ),
      actions: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: Text(
                  'Movies',
                  style: TextStyle(
                      fontSize: 14,
                      color: selectedTab == MenuTab.Movies
                          ? Colors.white
                          : Colors.blueGrey[500]),
                ),
                onPressed: () {
                  selectTab(MenuTab.Movies);
                },
              ),
              TextButton(
                child: Text(
                  'TV Shows',
                  style: TextStyle(
                      fontSize: 14,
                      color: selectedTab == MenuTab.TvShows
                          ? Colors.white
                          : Colors.blueGrey[500]),
                ),
                onPressed: () {
                  selectTab(MenuTab.TvShows);
                },
              ),
              TextButton(
                child: Text(
                  'My List',
                  style: TextStyle(
                      fontSize: 14,
                      color: selectedTab == MenuTab.MyList
                          ? Colors.white
                          : Colors.blueGrey[500]),
                ),
                onPressed: () {
                  selectTab(MenuTab.MyList);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
