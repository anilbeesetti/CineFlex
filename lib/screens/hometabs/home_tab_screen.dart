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
  void loadMovies(BuildContext context, page) {
    context.read<MovieProvider>().gettopRatedMovies(page: page);
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
                  title: 'Top Rated Movies',
                  onLoad: loadMovies,
                  media: context.watch<MovieProvider>().topRatedMovies,
                ),
              ),
            );
          },
          title: 'Top Movies',
        ),
        MovieListView(
          media: context.watch<MovieProvider>().topRatedMovies,
        ),
        CollectionHead(
          title: 'Top Tv Shows',
        ),
        MovieListView(
          media: context.watch<TvShowProvider>().topRatedTvShows,
        )
      ],
    );
  }
}
