class PlayingMovie {
  int id;
  String title;
  String backdropPath;
  PlayingMovie({required this.id, required this.title, required this.backdropPath});

  factory PlayingMovie.fromJson(Map<String, dynamic> json) {
    return PlayingMovie(
      title: json['title'] as String,
      backdropPath: json['backdrop_path'] as String,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'backdrop_path': backdropPath , 'id': id};
  }
}
