import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:imdb_api_example/model/populer_movie.dart';
import 'package:imdb_api_example/screens/movie_detail.dart';
import 'package:imdb_api_example/services/api_services.dart';

class PopularMoviesList extends StatelessWidget {
  const PopularMoviesList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PopulerMovie>>(
      future: ApiServices().getPopulerMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No popular movies found."));
        }
        final movies = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Popular Movies",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(thickness: 2, indent: 16, endIndent: 16),
            Container(
              height: 300,
              margin: EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return InkWell(
                    onTap: () {
                      Get.to(() => MovieDetailScreen(movieId: movie.id,));
                    },
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8),
                      leading: Image.network(
                        "https://image.tmdb.org/t/p/original/${movie.backdropPath}",
                      ),
                      title: Text(movie.title),
                      subtitle: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("⭐"),
                          Text(movie.voteAverage.toStringAsFixed(1)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
