class CastMember {
  final int id;
  final String name;
  final String originalName;
  final String character;
  final String creditId;
  final int castId;
  final int order;
  final int gender;
  final bool adult;
  final String knownForDepartment;
  final double popularity;
  final String? profilePath;

  CastMember({
    required this.id,
    required this.name,
    required this.originalName,
    required this.character,
    required this.creditId,
    required this.castId,
    required this.order,
    required this.gender,
    required this.adult,
    required this.knownForDepartment,
    required this.popularity,
    this.profilePath,
  });

  factory CastMember.fromJson(Map<String, dynamic> json) {
    return CastMember(
      id: json['id'],
      name: json['name'],
      originalName: json['original_name'],
      character: json['character'],
      creditId: json['credit_id'],
      castId: json['cast_id'],
      order: json['order'],
      gender: json['gender'],
      adult: json['adult'],
      knownForDepartment: json['known_for_department'],
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'],
    );
  }
}
