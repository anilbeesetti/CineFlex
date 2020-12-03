import 'package:cineflex/providers/data_provider.dart';
import 'package:cineflex/providers/movie_provider.dart';
import 'package:cineflex/providers/tvshow_provider.dart';
import 'package:cineflex/screens/collections_screen.dart';
import 'package:cineflex/widgets/collection_head.dart';
import 'package:cineflex/widgets/movie_list_view.dart';
import 'package:cineflex/widgets/page_carousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTabScreen extends StatelessWidget {
  void loadUpcomingMovies(BuildContext context, page) {
    context.read<MovieProvider>().getUpcomingMovies(page: page);
  }

  void loadPopularMovies(BuildContext context, page) {
    context.read<MovieProvider>().getPopularMovies(page: page);
  }

  void loadPopularTvShows(BuildContext context, page) {
    context.read<TvShowProvider>().getPopularTvShows(page: page);
  }

  void loadTopRatedTvShows(BuildContext context, page) {
    context.read<TvShowProvider>().getTopRatedTvShows(page: page);
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        PageViewWidget(
          height: 180,
          collection: context.watch<DataProvider>().getTrending,
        ),
        CollectionHead(
          onPress: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => CollectionScreen(
                  title: 'Upcoming Movies',
                  onLoad: loadUpcomingMovies,
                  media: context.watch<MovieProvider>().upcomingMovies,
                ),
              ),
            );
          },
          title: 'Upcoming Movies',
        ),
        MovieListView(
          media: context.watch<MovieProvider>().upcomingMovies,
        ),
        CollectionHead(
          onPress: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => CollectionScreen(
                  title: 'Popular Movies',
                  onLoad: loadPopularMovies,
                  media: context.watch<MovieProvider>().popularMovies,
                ),
              ),
            );
          },
          title: 'Popular Movies',
        ),
        MovieListView(
          media: context.watch<MovieProvider>().popularMovies,
        ),
        CollectionHead(
          onPress: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => CollectionScreen(
                  title: 'Top Rated Tv Shows',
                  onLoad: loadTopRatedTvShows,
                  media: context.watch<TvShowProvider>().topRatedTvShows,
                ),
              ),
            );
          },
          title: 'Top Tv Shows',
        ),
        MovieListView(
          media: context.watch<TvShowProvider>().topRatedTvShows,
        ),
        CollectionHead(
          onPress: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => CollectionScreen(
                  title: 'Popular Tv Shows',
                  onLoad: loadPopularTvShows,
                  media: context.watch<TvShowProvider>().popularTvShows,
                ),
              ),
            );
          },
          title: 'Popular Tv Shows',
        ),
        MovieListView(
          media: context.watch<TvShowProvider>().popularTvShows,
        ),
      ],
    );
  }
}
