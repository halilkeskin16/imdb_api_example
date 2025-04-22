class PopulerMovie {
  int id;
  String title;
  String releaseDate;
  String backdropPath;
  double voteAverage;
  PopulerMovie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.backdropPath,
    required this.voteAverage,
  });


  factory PopulerMovie.fromJson(Map<String, dynamic> json) {
    return PopulerMovie(
      title: json['title'] as String,
      releaseDate: json['release_date'] as String,
      id: json['id'] as int,
      backdropPath: json['backdrop_path'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'release_date': releaseDate,
      'id': id,
      'backdrop_path': backdropPath,
      'vote_average': voteAverage,
    };
  }
}