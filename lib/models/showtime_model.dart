class ShowtimeModel {
  String id;
  String date;
  MovieReference movieReference;
  FormatReference formatReference;
  Theater theater;
  String time;
  List<int> seatsBooked;

  ShowtimeModel(
      {required this.id,
      required this.date,
      required this.movieReference,
      required this.formatReference,
      required this.theater,
      required this.time,
      required this.seatsBooked});

  factory ShowtimeModel.fromJson(Map<String, dynamic> json) {
    return ShowtimeModel(
      id: json['_id'],
      date: json['date'],
      movieReference: MovieReference.fromJson(json['movie']),
      formatReference: FormatReference.fromJson(json['format']),
      theater: Theater.fromJson(json['theater']),
      time: json['time'],
      seatsBooked: json["seatsBooked"].cast<int>(),
    );
  }
}

class MovieReference {
  String id;
  String title;
  int runtime;
  RatedReference ratedReference;

  MovieReference(
      {required this.id,
      required this.title,
      required this.runtime,
      required this.ratedReference});

  factory MovieReference.fromJson(Map<String, dynamic> json) {
    return MovieReference(
      id: json['_id'],
      title: json['title'],
      runtime: json["runtime"],
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

class FormatReference {
  String id;
  String name;
  int seatPrice;
  String tech;

  FormatReference(
      {required this.id,
      required this.name,
      required this.seatPrice,
      required this.tech});

  factory FormatReference.fromJson(Map<String, dynamic> json) {
    return FormatReference(
      id: json['_id'],
      name: json['name'],
      seatPrice: json["seatPrice"],
      tech: json['tech'],
    );
  }
}

class Theater {
  String id;
  String name;
  int numberOfSeat;
  int numberOfRow;
  int numberOfColumn;

  Theater(
      {required this.id,
      required this.name,
      required this.numberOfSeat,
      required this.numberOfColumn,
      required this.numberOfRow});

  factory Theater.fromJson(Map<String, dynamic> json) {
    return Theater(
        id: json['_id'],
        name: json['name'],
        numberOfSeat: json["numberOfSeat"],
        numberOfColumn: json['numberOfColumn'],
        numberOfRow: json['numberOfRow']);
  }
}
