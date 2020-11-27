import 'package:cineflex/providers/data_provider.dart';
import 'package:cineflex/widgets/page_carousel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyListTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HomeTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageViewWidget(
          height: 180,
          collection: context.watch<DataProvider>().popularMovies,
        ),
      ],
    );
  }
}

class TvShowsTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MoviesTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
