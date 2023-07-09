class TicketModel {
  String? id;
  String userId;
  String showtimeId;
  String posterPath;
  String movieTitle;
  String date;
  String showtime;
  int runtime;
  String theater;
  List<int> seatIndex;
  List<String> seat;
  String snack;
  int totalPrice;
  int ticketPrice;
  int snackPrice;
  String paymentMethod;

  TicketModel(
      {this.id,
      required this.userId,
      required this.showtimeId,
      required this.posterPath,
      required this.movieTitle,
      required this.date,
      required this.showtime,
      required this.runtime,
      required this.theater,
      required this.seatIndex,
      required this.seat,
      required this.snack,
      required this.totalPrice,
      required this.ticketPrice,
      required this.snackPrice,
      required this.paymentMethod});

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
        id: json['_id'],
        userId: json['userId'],
        showtimeId: json['showtimeId'],
        posterPath: json['posterPath'],
        movieTitle: json['movieTitle'],
        date: json['date'],
        showtime: json['showtime'],
        runtime: json['runtime'],
        theater: json['theater'],
        seatIndex: json['seatIndex'].cast<int>(),
        seat: json['seat'].cast<String>(),
        snack: json['snack'] ?? "",
        totalPrice: json['totalPrice'],
        ticketPrice: json['ticketPrice'],
        snackPrice: json['snackPrice'],
        paymentMethod: json['paymentMethod']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['showtimeId'] = showtimeId;
    data['posterPath'] = posterPath;
    data['movieTitle'] = movieTitle;
    data['date'] = date;
    data['showtime'] = showtime;
    data['runtime'] = runtime;
    data['theater'] = theater;
    data['seatIndex'] = seatIndex.toList();
    data['seat'] = seat.toList();
    data['snack'] = snack;
    data['totalPrice'] = totalPrice;
    data['ticketPrice'] = ticketPrice;
    data['snackPrice'] = snackPrice;
    data['paymentMethod'] = paymentMethod;
    return data;
  }
}
