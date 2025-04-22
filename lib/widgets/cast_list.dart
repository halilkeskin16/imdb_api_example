import 'package:flutter/material.dart';
import 'package:imdb_api_example/services/api_services.dart';

class CastListWidget extends StatelessWidget {
  const CastListWidget({super.key , required this.movieId});
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: ApiServices().getMovieCast(movieId), builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text("Error: ${snapshot.error}"));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text("No now playing movies found."));
      }
      final movies = snapshot.data!;
      return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return ListTile(
            contentPadding: const EdgeInsets.all(8),
            leading: Container(
              child: Image.network(
                "https://image.tmdb.org/t/p/original/${movie.profilePath}",
              ),
            ),
            title: Text(movie.name),
            subtitle: Text(movie.character),
          );
        },
      );
    });
      
    
  }
}