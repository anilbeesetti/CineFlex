import 'package:carousel_slider/carousel_slider.dart';
import 'package:cineflex/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarouselScreen extends StatefulWidget {
  @override
  _CarouselScreenState createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 200,
          child: CarouselSlider.builder(
              itemCount: context.watch<DataProvider>().popularMovies.length,
              itemBuilder: (context, index) {
                var movies = context.watch<DataProvider>().popularMovies;
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500/${movies[index].backdropPath}',
                    fit: BoxFit.cover,
                  ),
                );
              },
              options: CarouselOptions(
                height: 200,
                autoPlay: false,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                initialPage: 0,
                viewportFraction: 0.85,
                scrollPhysics: FixedExtentScrollPhysics(),
              )),
        ),
      ),
    );
  }
}
