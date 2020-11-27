import 'package:cineflex/providers/data_provider.dart';
import 'package:cineflex/screens/home_tab_screens.dart';

import 'package:cineflex/widgets/top_bar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum MenuTab {
  Home,
  Movies,
  TvShows,
  MyList,
}

class _HomeScreenState extends State<HomeScreen> {
  MenuTab selectedTab = MenuTab.Home;
  @override
  void initState() {
    context.read<DataProvider>().getPopularMovies();
    super.initState();
  }

  void selectTab(MenuTab tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  Widget tabScreen() {
    if (selectedTab == MenuTab.Home) {
      return HomeTabScreen();
    } else if (selectedTab == MenuTab.Movies) {
      return MoviesTabScreen();
    } else if (selectedTab == MenuTab.TvShows) {
      return TvShowsTabScreen();
    } else {
      return MyListTabScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopBar(
                selectedTab: selectedTab,
                setTab: selectTab,
              ),
              tabScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
