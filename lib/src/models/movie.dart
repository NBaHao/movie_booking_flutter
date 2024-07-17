class Movie {
  String? name;
  int? duration;
  String? posterUrl;
  DateTime? releaseDate;
  List<String>? genres;
  List<Celeb>? actors;
  List<Celeb>? directors;
  String? languages;
  String? countries;
  String? censorRating;
  double? rating;
  int? totalVotes;
  String? storyline;
  bool? isPlaying;
  bool? isComing;
  Movie({
    this.name,
    this.duration,
    this.posterUrl,
    this.releaseDate,
    this.genres,
    this.actors,
    this.directors,
    this.languages,
    this.countries,
    this.censorRating,
    this.rating,
    this.totalVotes,
    this.storyline,
    this.isPlaying,
    this.isComing,
  });

   Map<String, dynamic> toJson() => {
        'name': name,
        'duration': duration,
        'posterUrl': posterUrl,
        'releaseDate': releaseDate?.toIso8601String(),
        'genres': genres,
        'actors': actors?.map((actor) => actor.toJson()).toList(),
        'directors': directors?.map((director) => director.toJson()).toList(),
        'languages': languages,
        'countries': countries,
        'censorRating': censorRating,
        'rating': rating,
        'totalVotes': totalVotes,
        'storyline': storyline,
        'is_playing': isPlaying,
        'is_coming': isComing,
      };
    factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      name: json['name'],
      duration: json['duration'],
      posterUrl: json['posterUrl'],
      releaseDate: DateTime.parse(json['releaseDate']),
      genres: List<String>.from(json['genres']),
      actors: List<Celeb>.from(json['actors'].map((actor) => Celeb.fromJson(actor))),
      directors: List<Celeb>.from(json['directors'].map((director) => Celeb.fromJson(director))),
      languages: json['languages'],
      countries: json['countries'],
      censorRating: json['censorRating'],
      rating: json['rating'],
      totalVotes: json['totalVotes'],
      storyline: json['storyline'],
      isPlaying: json['is_playing'],
      isComing: json['is_coming'],
    );
    }
}

class Celeb {
  String? name;
  String? infoUrl;
  String? imageUrl;
  Celeb({
    this.name,
    this.infoUrl,
    this.imageUrl,
  });
  Map<String, dynamic> toJson() => {
        'name': name,
        'infoUrl': infoUrl,
        'imageUrl': imageUrl,
      };
  factory Celeb.fromJson(Map<String, dynamic> json) {
  return Celeb(
    name: json['name'],
    infoUrl: json['infoUrl'],
    imageUrl: json['imageUrl'],
  );
  }
}