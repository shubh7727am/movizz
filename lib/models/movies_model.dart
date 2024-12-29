// movie_model.dart
class Movie {
  final int? id;  // Nullable
  final String? name;  // Nullable
  final String? type;  // Nullable
  final String? language;  // Nullable
  final List<String>? genres;  // Nullable
  final String? status;  // Nullable
  final String? premiered;  // Nullable
  final String? ended;  // Nullable
  final String? summary;  // Nullable
  final String? imageUrl;  // Nullable
  final String? highImageUrl;  // Nullable
  final String? officialSite;  // Nullable
  final double? rating;  // Nullable
  final String? scheduleTime;  // Nullable
  final List<String>? scheduleDays;  // Nullable
  final String? networkName;  // Nullable
  final String? networkCountry;  // Nullable

  Movie({
    this.id,
    this.name,
    this.type,
    this.language,
    this.genres,
    this.status,
    this.premiered,
    this.ended,
    this.highImageUrl,
    this.summary,
    this.imageUrl,
    this.officialSite,
    this.rating,
    this.scheduleTime,
    this.scheduleDays,
    this.networkName,
    this.networkCountry,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    var genresList = json['show']['genres'] != null
        ? List<String>.from(json['show']['genres'])
        : null;
    var scheduleList = json['show']['schedule']['days'] != null
        ? List<String>.from(json['show']['schedule']['days'])
        : null;

    return Movie(
      id: json['show']?['id'],
      name: json['show']?['name'],
      type: json['show']?['type'],
      language: json['show']?['language'],
      genres: genresList,
      status: json['show']?['status'],
      premiered: json['show']?['premiered'],
      ended: json['show']?['ended'],
      summary: json['show']?['summary'],
      imageUrl: json['show']?['image']?['medium'],
      highImageUrl: json['show']?['image']?['original'],
      officialSite: json['show']?['officialSite'],
      rating: json['show']?['rating'] != null
          ? json['show']['rating']['average']?.toDouble()
          : null,
      scheduleTime: json['show']?['schedule']?['time'],
      scheduleDays: scheduleList,
      networkName: json['show']?['network']?['name'],
      networkCountry: json['show']?['network']?['country']?['name'],
    );
  }
}
