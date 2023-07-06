import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket/model_views/movie_service.dart';
import 'package:movie_ticket/models/ticket_model.dart';
import 'package:movie_ticket/views/widgets/payment_bank_payment.dart';
import 'package:movie_ticket/views/widgets/payment_bill_card.dart';
import 'package:movie_ticket/views/widgets/payment_concession.dart';
import 'package:movie_ticket/views/widgets/payment_ticket_information.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../model_views/booking_service.dart';
import '../widgets/share_widgets/app_bar.dart';
import '../widgets/share_widgets/drawer.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String estimateEndingTime(String startTime, int runtime) {
    int startHour = int.parse(startTime.substring(0, 2));
    int startMin = int.parse(startTime.substring(3));
    int ending = startHour * 60 + startMin + runtime;
    int endingHour = ending ~/ 60;
    int endingMin = ending.remainder(60);
    if (endingHour >= 24) {
      endingHour = endingHour - 24;
    }
    if (endingHour < 10 && endingMin < 10) {
      return "0$endingHour:0$endingMin";
    } else if (endingHour < 10 && endingMin > 10) {
      return "0$endingHour:$endingMin";
    } else if (endingHour > 10 && endingMin < 10) {
      return "$endingHour:0$endingMin";
    } else {
      return "$endingHour:$endingMin";
    }
  }

  Future booking(
    String userId,
    String showtimeId,
    String posterPath,
    String movieTitle,
    String date,
    String showtime,
    int runtime,
    String theater,
    List<int> seat,
    String? snack,
    int totalPrice,
    int ticketPrice,
    int snackPrice,
    String paymentMethod,
  ) async {
    TicketModel ticketModel = TicketModel(
        userId: userId,
        showtimeId: showtimeId,
        posterPath: posterPath,
        movieTitle: movieTitle,
        date: date,
        showtime: showtime,
        runtime: runtime,
        theater: theater,
        seat: seat,
        snack: snack,
        totalPrice: totalPrice,
        ticketPrice: ticketPrice,
        snackPrice: snackPrice,
        paymentMethod: paymentMethod);
    BookingService bookingService =
        Provider.of<BookingService>(context, listen: false);
    bookingService.isSendingSuccessful = false;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 141, 19, 11),
            ),
          );
        });
    await bookingService.sendConfirmBookingToApi(ticketModel);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.of(context).pop();
    if (bookingService.isSendingSuccessful == true) {
      print("Sending success");
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Center(
              child: CupertinoAlertDialog(
                title: const Text("Success"),
                actions: [
                  CupertinoDialogAction(
                      onPressed: () {
                        bookingService.ticketPrice = 0;
                        bookingService.bookingPrice = 0;
                        bookingService.numberOfSeats = 0;
                        bookingService.selectedSeats = [];
                        bookingService.selectedSeatsIndex = [];
                        bookingService.selectedSnacks = "";
                        bookingService.listSelectedSnacks = [];
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      },
                      child: const Text("Home")),
                  CupertinoDialogAction(
                      onPressed: () {
                        bookingService.ticketPrice = 0;
                        bookingService.bookingPrice = 0;
                        bookingService.numberOfSeats = 0;
                        bookingService.selectedSeats = [];
                        bookingService.selectedSeatsIndex = [];
                        bookingService.selectedSnacks = "";
                        bookingService.listSelectedSnacks = [];
                        Navigator.of(context).pushNamed('/ticket');
                      },
                      child: const Text("My ticket")),
                ],
                content: const Text("Booked successfully"),
              ),
            );
          });
      await bookingService.getListTicketFromApi(user.uid);
    }
  }

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    BookingService bookingService = Provider.of<BookingService>(context);
    MovieService movieService = Provider.of<MovieService>(context);
    return Scaffold(
        backgroundColor: Colors.black,
        drawer: DrawerWidget(),
        body: CustomScrollView(slivers: [
          AppBarWidget(
            leadingWidget: Icon(
              Icons.adaptive.arrow_back,
              size: 8.w,
              color: Colors.white,
            ),
            leadingOnnClick: () {
              bookingService.ticketPrice = 0;
              bookingService.bookingPrice = 0;
              bookingService.numberOfSeats = 0;
              bookingService.selectedSeats = [];
              bookingService.selectedSeatsIndex = [];
              bookingService.selectedSnacks = "";
              bookingService.listSelectedSnacks = [];
              Navigator.popUntil(context, ModalRoute.withName('/showtime'));
            },
            titleWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Payment",
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
                // const SizedBox(
                //   height: 2,
                // ),
              ],
            ),
            isCenter: false,
            expandedHeight: 0,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            BillCard(
                imagePath: movieService.selectedMovie!.posterPath,
                title: movieService.selectedMovie!.title,
                rated: movieService.selectedMovie!.rated.symbol,
                date: bookingService.bookingDate,
                startTime: bookingService.showtimeDetail!.time,
                endingTime: estimateEndingTime(
                    bookingService.showtimeDetail!.time,
                    movieService.selectedMovie!.runtime),
                theaterName: bookingService.showtimeDetail!.theater.name,
                seats: bookingService.selectedSeats,
                snacks: bookingService.selectedSnacks,
                totalPayment: bookingService.bookingPrice),
            TicketInformation(
                quantity: bookingService.selectedSeats.length,
                subTotal: bookingService.ticketPrice),
            bookingService.listSelectedSnacks.isNotEmpty
                ? Concession(
                    selectedSnacks: bookingService.listSelectedSnacks,
                    subTotal: bookingService.snackPrice)
                : Container(),
            const BankPayment(),
            GestureDetector(
              onTap: () {
                booking(
                    user.uid,
                    bookingService.selectedShowtimeId,
                    movieService.selectedMovie!.posterPath,
                    movieService.selectedMovie!.title,
                    DateFormat('EEEE, MMM d, yyyy')
                        .format(bookingService.bookingDate),
                    bookingService.showtimeDetail!.time,
                    movieService.selectedMovie!.runtime,
                    bookingService.showtimeDetail!.theater.name,
                    bookingService.selectedSeatsIndex,
                    bookingService.selectedSnacks,
                    bookingService.bookingPrice,
                    bookingService.ticketPrice,
                    bookingService.snackPrice,
                    bookingService.paymentMethod);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 1.h),
                child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 150, 3, 3),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    height: 5.h,
                    child: const Center(
                      child: Text(
                        "BOOK NOW",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
            ),
          ]))
        ]));
  }
}
