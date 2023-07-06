import 'package:flutter/cupertino.dart';
import 'package:movie_ticket/models/repositories/showtime_repository.dart';
import 'package:movie_ticket/models/repositories/ticket_repository.dart';
import 'package:movie_ticket/models/selected_snacks_model.dart';
import 'package:movie_ticket/models/showtime_management_model.dart';
import 'package:movie_ticket/models/showtime_model.dart';
import 'package:movie_ticket/models/snack_model.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket/models/ticket_model.dart';
import '../models/repositories/snack_repository.dart';

class BookingService extends ChangeNotifier {
  final SnackRepository snackRepository = SnackRepository();
  final ShowtimeRepository showtimeRepository = ShowtimeRepository();
  final TicketRepository ticketRepository = TicketRepository();

  int ticketPrice = 0;
  int snackPrice = 0;
  int bookingPrice = 0;
  String paymentMethod = "ATM card";

  int numberOfSeats = 0;
  List<String> selectedSeats = [];
  List<int> selectedSeatsIndex = [];

  List<SnackModel> listSnack = []; // fetch from database
  List<SelectedSnacks> listSelectedSnacks = []; // selecte from app
  String selectedSnacks = "";

  List<ShowtimeManagementModel> listShowtime =
      []; // all movie's showtime, have many object in list
  List<ShowtimeManagementModel> showtimesOfMovie =
      []; //sigle movie's showtime, have only one object in list
  ShowtimeModel? showtimeDetail; //showtime detail
  String selectedShowtimeId = "";

  void getListSnackFromApi() async {
    final list = await snackRepository.getListSnack();
    listSnack = list;
    notifyListeners();
  }

  void getListShowtimeFromApi(String date) async {
    final list = await showtimeRepository.getListShowtime(date);
    listShowtime = list;
    notifyListeners();
  }

  Future<void> getShowtimesByMovie(String date, String? movieId) async {
    final showtimes =
        await showtimeRepository.getShowtimeByMovie(date, movieId);

    showtimesOfMovie = showtimes;
    notifyListeners();
  }

  void getDetailShowtimeFromApi(String showtimeId) async {
    final detail = await showtimeRepository.getDetailShowtime(showtimeId);
    showtimeDetail = detail;
    notifyListeners();
  }

  String _selectedDate = DateFormat('yyyy-MM-dd').format(DateTime(2023, 5, 27));
  String _currentDate = "";
  DateTime bookingDate = DateTime(2023, 5, 27); //pseudo current day

  String get selectedDate => _selectedDate;

  set selectedDate(String date) {
    _selectedDate = date;
    notifyListeners();
  }

  String get currentDate => _currentDate;

  set currentDate(String date) {
    _currentDate = date;
    notifyListeners();
  }

  bool isSendingSuccessful = false;
  Future<void> sendConfirmBookingToApi(TicketModel ticketModel) async {
    final result = await ticketRepository.confirmBooking(ticketModel);
    if (result == true) {
      isSendingSuccessful = true;
    }
    notifyListeners();
  }

  List<TicketModel> listTicket = [];
  Future<void> getListTicketFromApi(String userId) async {
    final tickets = await ticketRepository.getListTicketByUserId(userId);
    listTicket = tickets;
    notifyListeners();
  }
}
