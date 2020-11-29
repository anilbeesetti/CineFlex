import 'package:cineflex/providers/movie_provider.dart';
import 'package:cineflex/widgets/collection_head.dart';
import 'package:cineflex/widgets/movie_list_view.dart';
import 'package:cineflex/widgets/page_carousel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoviesTabScreen extends StatefulWidget {
  @override
  _MoviesTabScreenState createState() => _MoviesTabScreenState();
}

class _MoviesTabScreenState extends State<MoviesTabScreen> {
  bool isLoading = true;
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
          collection: context.watch<MovieProvider>().popularMovies,
        ),
        CollectionHead(
          title: 'Now Playing',
        ),
        MovieListView(
          media: context.watch<MovieProvider>().nowPlayingMovies,
        ),
        CollectionHead(
          title: 'Top Movies',
        ),
        MovieListView(
          media: context.watch<MovieProvider>().topRatedMovies,
        ),
      ],
    );
  }
}
