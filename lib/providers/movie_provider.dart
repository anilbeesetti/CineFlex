import 'package:cineflex/models/movie_model.dart';
import 'package:flutter/foundation.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> popularMovies = [
    Movie(
      backdropPath: 'ehroerueor',
      genreId: [45, 34, 23],
      id: 234234,
      orginalLanguage: 'en',
      overview: 'fdvnoenfkdfksoenlsoekslf',
      posterPath: 'soeldfkvellksdkjfjv',
      releaseDate: 'doenkdfj',
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
          genreId: movie['genre_ids'],
          overview: movie['overview'],
          backdropPath: movie['backdrop_path'],
          orginalLanguage: movie['original_language'],
          posterPath: movie['poster_path'],
          releaseDate: movie['release_date'],
        ),
      );
    });
    value++;
    notifyListeners();
    print('object');
  }
}
