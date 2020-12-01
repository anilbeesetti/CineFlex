import 'package:cineflex/providers/tvshow_provider.dart';
import 'package:cineflex/widgets/collection_head.dart';
import 'package:cineflex/widgets/movie_list_view.dart';
import 'package:cineflex/widgets/page_carousel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvShowsTabScreen extends StatefulWidget {
  @override
  _TvShowsTabScreenState createState() => _TvShowsTabScreenState();
}

class _TvShowsTabScreenState extends State<TvShowsTabScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageViewWidget(
          height: 180,
          collection: context.watch<TvShowProvider>().trendingTvShows,
        ),
        CollectionHead(
          title: 'On the Air',
        ),
        MovieListView(
          media: context.watch<TvShowProvider>().onTheAirTvShows,
        ),
        CollectionHead(
          title: 'Popular',
        ),
        MovieListView(
          media: context.watch<TvShowProvider>().popularTvShows,
        ),
        CollectionHead(
          title: 'Top Tv Shows',
        ),
        MovieListView(
          media: context.watch<TvShowProvider>().topRatedTvShows,
        ),
      ],
    );
  }
}
