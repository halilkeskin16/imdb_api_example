
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:imdb_api_example/model/movies_details.dart';
import 'package:imdb_api_example/model/playing_now_movie.dart';
import 'package:imdb_api_example/model/populer_movie.dart';
import 'package:imdb_api_example/secret.dart';

final String apikey = Secret.apikey;

class ApiServices {

  final String nowPlayinUrl = 'https://api.themoviedb.org/3/movie/now_playing?api_key=$apikey';
  final String popularUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=$apikey';
  Future<List<PlayingMovie>> getNowPlayingMovies() async {
    Uri url = Uri.parse(nowPlayinUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      return data.map((movie) => PlayingMovie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load now playing movies');
    }
    
  }

  Future<List<PopulerMovie>> getPopulerMovies() async {
    Uri url = Uri.parse(popularUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['results'];
      return data.map((movie) => PopulerMovie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load now playing movies');
    }
  }


Future<MovieDetail> getMovieDetails(int movieId) async {
  final String url =
      'https://api.themoviedb.org/3/movie/$movieId?api_key=$apikey';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    return MovieDetail.fromJson(jsonData);
  } else {
    throw Exception('Failed to load movie details');
  }
}


}