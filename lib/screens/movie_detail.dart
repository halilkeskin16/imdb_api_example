import 'package:flutter/material.dart';
import 'package:imdb_api_example/model/movies_details.dart';
import 'package:imdb_api_example/services/api_services.dart';
import 'package:imdb_api_example/widgets/cast_list.dart';

class MovieDetailScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: FutureBuilder<MovieDetail>(
          future: ApiServices().getMovieDetails(movieId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Hata: ${snapshot.error}"));
            } else if (!snapshot.hasData) {
              return const Center(child: Text("Film detayı bulunamadı."));
            }
            final movie = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      "https://image.tmdb.org/t/p/original/${movie.backdropPath}",
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        color: Colors.black.withValues(alpha: 150),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        child: Text(
                          movie.originalTitle,
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        "https://image.tmdb.org/t/p/w200${movie.posterPath}",
                        height: 150,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(movie.tagline ?? ''),
                            const SizedBox(height: 8),
                            Text("⭐ ${movie.voteAverage.toStringAsFixed(1)}"),
                            const SizedBox(height: 8),
                            Text("⏱️ ${movie.runtime} minutes"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: "Overview"),
                    Tab(text: "Cast & Crew"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              movie.overview,
                              style: const TextStyle(fontSize: 16),
                            ),
                             Wrap(
                              spacing: 8,
                              children: movie.genres
                                  .map((genre) => Chip(label: Text(genre.name)))
                                  .toList(),
                            ),
                            const SizedBox(height: 20),
                            Text("🎬 Language: ${movie.originalLanguage.toUpperCase()}"),
                            const SizedBox(height: 4),
                            Text("💰 Budget: \$${movie.budget}"),
                            const SizedBox(height: 4),
                            Text("🗓️ Release Date: ${movie.releaseDate}"),
                          ],
                        ),
                      ),
                      CastListWidget(movieId: movieId),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
