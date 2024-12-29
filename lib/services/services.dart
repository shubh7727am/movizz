// services.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/movies_model.dart';


class MovieService {
  // Base URL of the API
  final String _baseUrl = 'https://api.tvmaze.com/search/shows?q=all';


  // Fetch all movies from the API
  Future<List<Movie>> searchMovies({required String search}) async {
    final response = await http.get(Uri.parse("https://api.tvmaze.com/search/shows?q=$search"));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((movieData) => Movie.fromJson(movieData)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((movieData) => Movie.fromJson(movieData)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }



  List<Movie> sortMovies<T extends Comparable>({
    required List<Movie> movies,
    required T Function(Movie movie) criteria,
    bool descending = true,
    bool topMovies = false,
  }) {
    movies.sort((a, b) {
      T valueA = criteria(a);
      T valueB = criteria(b);

      // Compare values based on the desired order
      return descending
          ? valueB.compareTo(valueA) // Descending order
          : valueA.compareTo(valueB); // Ascending order
    });

    return topMovies ? movies.take(4).toList() : movies;
  }


}
