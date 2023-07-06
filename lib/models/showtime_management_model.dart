class ShowtimeManagementModel {
  String id;
  String date;
  MovieReference movie;
  List<Format> formats;

  ShowtimeManagementModel(
      {required this.id,
      required this.date,
      required this.movie,
      required this.formats});

  factory ShowtimeManagementModel.fromJson(Map<String, dynamic> json) {
    return ShowtimeManagementModel(
      id: json['_id'],
      date: json['date'],
      movie: MovieReference.fromJson(json['movie']),
      formats: json["formats"]
          .map<Format>((format) => Format.fromJson(format))
          .toList(),
    );
  }
}

class MovieReference {
  String id;
  String title;
  RatedReference ratedReference;

  MovieReference(
      {required this.id, required this.title, required this.ratedReference});

  factory MovieReference.fromJson(Map<String, dynamic> json) {
    return MovieReference(
      id: json['_id'],
      title: json['title'],
      ratedReference: RatedReference.fromJson(json['rated']),
    );
  }
}

class RatedReference {
  String id;
  String symbol;

  RatedReference({required this.id, required this.symbol});

  factory RatedReference.fromJson(Map<String, dynamic> json) {
    return RatedReference(
      id: json['_id'],
      symbol: json['symbol'],
    );
  }
}

class Format {
  String id;
  String name;
  int seatPrice;
  String tech;
  List<ShowtimeReference> showtimes;

  Format(
      {required this.id,
      required this.name,
      required this.seatPrice,
      required this.tech,
      required this.showtimes});

  factory Format.fromJson(Map<String, dynamic> json) {
    return Format(
      id: json['_id'],
      name: json['name'],
      seatPrice: json['seatPrice'],
      tech: json['tech'],
      showtimes: json["showtimes"]
          .map<ShowtimeReference>(
              (showtime) => ShowtimeReference.fromJson(showtime))
          .toList(),
    );
  }
}

class ShowtimeReference {
  String id;
  String time;

  ShowtimeReference({required this.id, required this.time});

  factory ShowtimeReference.fromJson(Map<String, dynamic> json) {
    return ShowtimeReference(
      id: json['_id'],
      time: json['time'],
    );
  }
}
