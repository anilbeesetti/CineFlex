import 'package:cineflex/models/movie_model.dart';
import 'package:flutter/foundation.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> popularMovies = [
    Movie(
      backdropPath: 'ehroerueor',
      id: 234234,
      orginalLanguage: 'en',
      posterPath: 'soeldfkvellksdkjfjv',
      title: 'hello',
    )
  ];

  int value = 0;

  void increment() {
    value++;
    notifyListeners();
  }

  void addPopularMovies(responseData) {
    responseData['results'].forEach((movie) {
      popularMovies.add(
        Movie(
          id: movie['id'],
          title: movie['original_title'],
          backdropPath: movie['backdrop_path'],
          orginalLanguage: movie['original_language'],
          posterPath: movie['poster_path'],
        ),
      );
    });
    value++;
    notifyListeners();
    print('object');
  }
}
