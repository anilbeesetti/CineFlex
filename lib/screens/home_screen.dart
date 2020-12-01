import 'package:cineflex/constansts.dart';
import 'package:cineflex/providers/data_provider.dart';
import 'package:cineflex/providers/movie_provider.dart';
import 'package:cineflex/providers/tvshow_provider.dart';
import 'package:cineflex/widgets/bottom_nav_bar.dart';
import 'package:cineflex/widgets/home_app_bar.dart';
import 'package:provider/provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'hometabs/home_tab_screen.dart';
import 'hometabs/movies_tab_screen.dart';
import 'hometabs/mylist_tab_screen.dart';
import 'hometabs/tvshows_tab_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  MenuTab selectedTab = MenuTab.Home;
  NavigationTab selectedNavigationTab = NavigationTab.Home;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var dataProvider = context.read<DataProvider>();
    var movieProvider = context.read<MovieProvider>();
    var tvShowProvider = context.read<TvShowProvider>();

    dataProvider.resetTrending();

    tvShowProvider.resetTopRatedTvShows();

    await dataProvider.getTrendingMedia();
    await movieProvider.getTrendingMovies();
    await tvShowProvider.getPopularTvShows();
    await movieProvider.getUpcomingMovies();
    await tvShowProvider.getTrendingTvShows();
    movieProvider.getNowPlayingMovies();
    movieProvider.getPopularMovies();
    movieProvider.gettopRatedMovies();
    tvShowProvider.getTopRatedTvShows();
    tvShowProvider.getOnTheAirTvShows();
    setState(() {
      isLoading = false;
    });
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
        child: CustomScrollView(
          slivers: [
            HomeAppBar(
              selectedTab: selectedTab,
              selectTab: selectTab,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : tabScreen(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        backgroundColor: kPrimaryColor,
        tabs: [
          NavButton(
            isSelected: selectedNavigationTab == NavigationTab.Home,
            label: 'Home',
            icon: Icons.home_outlined,
            iconColor: Colors.blueGrey[500],
            selectedTabBackgroundColor: kAccentColor.withOpacity(0.2),
            selectedIconColor: kAccentColor,
            selectedTextColor: kAccentColor,
            onPress: () {
              setState(() {
                selectedNavigationTab = NavigationTab.Home;
              });
            },
          ),
          NavButton(
            isSelected: selectedNavigationTab == NavigationTab.Search,
            label: 'search',
            icon: Icons.search_outlined,
            iconColor: Colors.blueGrey[500],
            selectedTabBackgroundColor: kAccentColor.withOpacity(0.2),
            selectedIconColor: kAccentColor,
            selectedTextColor: kAccentColor,
            onPress: () {
              setState(() {
                selectedNavigationTab = NavigationTab.Search;
              });
            },
          ),
          NavButton(
            isSelected: selectedNavigationTab == NavigationTab.Downloads,
            label: 'Downloads',
            icon: Icons.download_outlined,
            iconColor: Colors.blueGrey[500],
            selectedTabBackgroundColor: kAccentColor.withOpacity(0.2),
            selectedIconColor: kAccentColor,
            selectedTextColor: kAccentColor,
            onPress: () {
              setState(() {
                selectedNavigationTab = NavigationTab.Downloads;
              });
            },
          ),
          NavButton(
            isSelected: selectedNavigationTab == NavigationTab.Account,
            label: 'Profile',
            icon: Icons.account_circle_outlined,
            iconColor: Colors.blueGrey[500],
            selectedTabBackgroundColor: kAccentColor.withOpacity(0.2),
            selectedIconColor: kAccentColor,
            selectedTextColor: kAccentColor,
            onPress: () {
              setState(() {
                selectedNavigationTab = NavigationTab.Account;
              });
            },
          ),
        ],
      ),
    );
  }
}
