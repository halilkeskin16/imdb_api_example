import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:imdb_api_example/model/playing_now_movie.dart';
import 'package:imdb_api_example/services/api_services.dart';

class NowPlayingMovies extends StatelessWidget {
  const NowPlayingMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PlayingMovie>>(
      future: ApiServices().getNowPlayingMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No now playing movies found."));
        }

        final movies = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Now Playing Movies",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(thickness: 2, indent: 16, endIndent: 16),
            CarouselSlider.builder(
              itemCount: movies.length,
              itemBuilder: (context, index, realIndex) {
                final movie = movies[index];
                return Column(
                  children: [
                    Image.network(
                      "https://image.tmdb.org/t/p/original/${movie.backdropPath}",
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10),
                    Text(movie.title),
                  ],
                );
              },
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
              ),
            ),
          ],
        );
      },
    );
  }
}
