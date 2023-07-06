class MovieModel {
  String id;
  String title;
  List<Genre> genres;
  String posterPath;
  String backdropPath;
  String releaseDate;
  String overview;
  Rated rated;
  bool isReleased;
  int runtime;
  String language;
  String trailer;
  List<String> cast;
  String director;

  MovieModel(
      {required this.id,
      required this.title,
      required this.genres,
      required this.posterPath,
      required this.backdropPath,
      required this.releaseDate,
      required this.overview,
      required this.rated,
      required this.isReleased,
      required this.runtime,
      required this.language,
      required this.trailer,
      required this.cast,
      required this.director});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        id: json["_id"],
        title: json["title"],
        genres: json["genres"]
            .map<Genre>((genre) => Genre.fromJson(genre))
            .toList(),
        posterPath: "https://image.tmdb.org/t/p/w300" + json["posterPath"],
        backdropPath: json["backdropPath"],
        releaseDate: json["releaseDate"],
        overview: json["overview"],
        rated: Rated.fromJson(json["rated"]),
        isReleased: json["isReleased"],
        runtime: json["runtime"],
        language: json["language"],
        trailer: json["trailer"],
        cast: json["cast"].cast<String>(),
        director: json["director"]);
  }
}

class Genre {
  String id;
  String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(id: json["_id"], name: json["name"]);
  }
}

class Rated {
  String id;
  String symbol;
  String description;

  Rated({required this.id, required this.symbol, required this.description});

  factory Rated.fromJson(Map<String, dynamic> json) {
    return Rated(
        id: json["_id"],
        symbol: json["symbol"],
        description: json["description"]);
  }
}
