import 'package:flutter/material.dart';
import 'package:imdb_api_example/widgets/now_playing_movies.dart';
import 'package:imdb_api_example/widgets/populer_movies.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            NowPlayingMovies(),
            PopularMoviesList(),
          ],
        ),
      ),
    );
  }
}
