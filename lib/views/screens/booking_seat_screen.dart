import 'package:flutter/material.dart';
import 'package:movie_ticket/model_views/booking_service.dart';
import 'package:movie_ticket/views/widgets/share_widgets/booking_bottom_bar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../../model_views/movie_service.dart';
import '../widgets/share_widgets/seat.dart';
import '../widgets/share_widgets/app_bar.dart';

class BookingSeatScreen extends StatefulWidget {
  const BookingSeatScreen({Key? key}) : super(key: key);

  @override
  State<BookingSeatScreen> createState() => _BookingSeatScreenState();
}

class _BookingSeatScreenState extends State<BookingSeatScreen> {
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

  List<String> seatChar = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K'
  ];

  String convertSeatFromIndex(int index, int row, int col) {
    //ex: 0 -> A1
    for (int i = 1; i <= row; i++) {
      if (index < i * col) {
        int postion = index + 1 - (i - 1) * col;
        return "${seatChar[i - 1]}$postion";
      }
    }
    return "";
  }

  int convertSeatToIndex(String seat, int col) {
    //ex: A1 -> 0
    String symb = seat.substring(0, 1);
    int num = int.parse(seat.substring(1));
    for (int i = 0; i < seatChar.length; i++) {
      if (symb == seatChar[i]) {
        return col * i + num - 1;
      }
    }
    return 0;
  }

  List<int> listIndexStandardSeat(int numberOfCol) {
    List<int> standardIndex = [];
    for (int i = 0; i < numberOfCol; i++) {
      standardIndex.add(i); // first row contains standard seat
    }
    return standardIndex;
  }

  List<int> listIndexOccupidedSeat(int numberOfCol, List<int> occupidedSeats) {
    //fetch from database
    List<int> occupiedIndex = [];
    for (int i = 0; i < occupidedSeats.length; i++) {
      //occupiedIndex.add(convertSeatToIndex(occupidedSeats[i], numberOfCol)); //if list of occupided seats
      //from database it's list of String
      //(like A1, B3, v.v)
      occupiedIndex.add(occupidedSeats[i]); // list from database it's int list
    }
    return occupiedIndex;
  }

  List<int> selectedIndex = [];

  @override
  void initState() {
    BookingService bookingService =
        Provider.of<BookingService>(context, listen: false);
    bookingService.getDetailShowtimeFromApi(bookingService.selectedShowtimeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BookingService bookingService = Provider.of<BookingService>(context);
    MovieService movieService =
        Provider.of<MovieService>(context, listen: false);
    final showtimeDetail = bookingService.showtimeDetail;
    return showtimeDetail != null
        ? Scaffold(
            backgroundColor: Colors.black,
            //endDrawer: DrawerWidget(),
            bottomNavigationBar: BookingBottomBar(
              movieTitle: showtimeDetail.movieReference.title,
              movieRated: showtimeDetail.movieReference.ratedReference.symbol,
              movieFormat: showtimeDetail.formatReference.name,
              bookingPrice: bookingService.bookingPrice,
              numberOfSeat: bookingService.numberOfSeats,
              snacks: bookingService.selectedSnacks,
              onTap: () {
                movieService
                    .getDetailMovieFromApi(showtimeDetail.movieReference.id);
                Navigator.of(context).pushNamed('/snack');
              },
            ),
            body: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
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
                  Navigator.of(context).pop();
                },
                titleWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      showtimeDetail.movieReference.title,
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "${showtimeDetail.theater.name}  ${DateFormat('dd-MM-yy').format(bookingService.bookingDate)}  ${showtimeDetail.time} ~ ${estimateEndingTime(showtimeDetail.time, showtimeDetail.movieReference.runtime)}",
                      style: TextStyle(color: Colors.grey, fontSize: 9.sp),
                    ),
                  ],
                ),
                isCenter: false,
                expandedHeight: 0,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                InteractiveViewer(
                    //boundaryMargin: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                      child: Center(
                        child: Text(
                          "SCREEN",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Color.fromARGB(255, 90, 89, 89),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      height: showtimeDetail.theater.numberOfColumn * 8.w,
                      width: showtimeDetail.theater.numberOfColumn * 8.w,
                      color: Colors.black,
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: showtimeDetail.theater.numberOfRow *
                              showtimeDetail.theater.numberOfColumn,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      showtimeDetail.theater.numberOfColumn),
                          itemBuilder: (BuildContext context, int index) {
                            if (listIndexOccupidedSeat(
                                    showtimeDetail.theater.numberOfColumn,
                                    showtimeDetail.seatsBooked) //ocuppided seat
                                .contains(index)) {
                              return Seat(
                                ontapFunction: null,
                                backgroundColor:
                                    Color.fromARGB(255, 192, 192, 192),
                                child: SizedBox(
                                    width: 8.w,
                                    height: 8.w,
                                    child: CustomPaint(
                                      painter: CrossDrawPaint(),
                                      child: Container(),
                                    )),
                              );
                            } else if (selectedIndex.contains(index)) {
                              //selected seat
                              return Seat(
                                ontapFunction: () {
                                  setState(() {
                                    selectedIndex.removeWhere(
                                        (element) => element == index);
                                    bookingService.selectedSeatsIndex
                                        .removeWhere(
                                            (element) => element == index);
                                    bookingService.selectedSeats.removeWhere(
                                        (element) =>
                                            element ==
                                            convertSeatFromIndex(
                                                index,
                                                showtimeDetail
                                                    .theater.numberOfRow,
                                                showtimeDetail
                                                    .theater.numberOfColumn));

                                    int standard = 0;
                                    int vip = 0;
                                    for (int i = 0;
                                        i < bookingService.selectedSeats.length;
                                        i++) {
                                      if (bookingService.selectedSeats[i]
                                              .substring(0, 1) ==
                                          'A') {
                                        standard++;
                                      } else {
                                        vip++;
                                      }
                                    }
                                    bookingService.numberOfSeats =
                                        standard + vip;

                                    bookingService.ticketPrice = standard *
                                            (showtimeDetail
                                                    .formatReference.seatPrice -
                                                20000) +
                                        vip *
                                            showtimeDetail
                                                .formatReference.seatPrice;
                                    bookingService.bookingPrice =
                                        bookingService.ticketPrice;
                                    print(bookingService.selectedSeatsIndex);
                                    print(bookingService.selectedSeats);
                                  });
                                },
                                backgroundColor:
                                    Color.fromARGB(255, 199, 37, 37),
                                child: Text(
                                  convertSeatFromIndex(
                                    index,
                                    showtimeDetail.theater.numberOfRow,
                                    showtimeDetail.theater.numberOfColumn,
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            } else if (listIndexStandardSeat(
                              showtimeDetail.theater.numberOfColumn,
                            ).contains(index)) {
                              //standard seat aka seat at the first row
                              return Seat(
                                ontapFunction: () {
                                  setState(() {
                                    selectedIndex.add(index);
                                    bookingService.selectedSeatsIndex
                                        .add(index);
                                    bookingService.selectedSeats
                                        .add(convertSeatFromIndex(
                                      index,
                                      showtimeDetail.theater.numberOfRow,
                                      showtimeDetail.theater.numberOfColumn,
                                    ));
                                    int standard = 0;
                                    int vip = 0;
                                    for (int i = 0;
                                        i < bookingService.selectedSeats.length;
                                        i++) {
                                      if (bookingService.selectedSeats[i]
                                              .substring(0, 1) ==
                                          'A') {
                                        standard++;
                                      } else {
                                        vip++;
                                      }
                                    }
                                    bookingService.numberOfSeats =
                                        standard + vip;
                                    bookingService.ticketPrice = standard *
                                            (showtimeDetail
                                                    .formatReference.seatPrice -
                                                20000) +
                                        vip *
                                            showtimeDetail
                                                .formatReference.seatPrice;
                                    bookingService.bookingPrice =
                                        bookingService.ticketPrice;
                                    print(bookingService.selectedSeatsIndex);
                                    print(bookingService.selectedSeats);
                                  });
                                },
                                backgroundColor:
                                    Color.fromARGB(255, 156, 142, 98),
                                child: Text(
                                  convertSeatFromIndex(
                                    index,
                                    showtimeDetail.theater.numberOfRow,
                                    showtimeDetail.theater.numberOfColumn,
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            } else {
                              return Seat(
                                  //vip seat aka remainder of all seat
                                  ontapFunction: () {
                                    setState(() {
                                      selectedIndex.add(index);
                                      bookingService.selectedSeatsIndex
                                          .add(index);
                                      bookingService.selectedSeats
                                          .add(convertSeatFromIndex(
                                        index,
                                        showtimeDetail.theater.numberOfRow,
                                        showtimeDetail.theater.numberOfColumn,
                                      ));
                                      int standard = 0;
                                      int vip = 0;
                                      for (int i = 0;
                                          i <
                                              bookingService
                                                  .selectedSeats.length;
                                          i++) {
                                        if (bookingService.selectedSeats[i]
                                                .substring(0, 1) ==
                                            'A') {
                                          standard++;
                                        } else {
                                          vip++;
                                        }
                                      }
                                      bookingService.numberOfSeats =
                                          standard + vip;
                                      bookingService.ticketPrice = standard *
                                              (showtimeDetail.formatReference
                                                      .seatPrice -
                                                  20000) +
                                          vip *
                                              showtimeDetail
                                                  .formatReference.seatPrice;
                                      bookingService.bookingPrice =
                                          bookingService.ticketPrice;
                                      print(bookingService.selectedSeatsIndex);
                                      print(bookingService.selectedSeats);
                                    });
                                  },
                                  backgroundColor:
                                      Color.fromARGB(255, 94, 19, 35),
                                  child: Text(
                                    convertSeatFromIndex(
                                      index,
                                      showtimeDetail.theater.numberOfRow,
                                      showtimeDetail.theater.numberOfColumn,
                                    ),
                                  ));
                            }
                          }),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    const SeatDescriptionWidget()
                  ],
                ))
              ]))
            ]))
        : const Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            )),
          );
  }
}

class SeatDescriptionWidget extends StatelessWidget {
  const SeatDescriptionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //padding: EdgeInsets.only(left: 10.w),
      width: 70.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        color: Colors.grey,
                        width: 5.w,
                        height: 5.w,
                        child: CustomPaint(
                          painter: CrossDrawPaint(),
                          child: Container(),
                        )),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Occupied',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Color.fromARGB(255, 139, 127, 87),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 5.w,
                        height: 5.w,
                        child: Container(
                          color: Colors.red,
                        )),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Selected',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Color.fromARGB(255, 139, 127, 87),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 5.w,
                        height: 5.w,
                        child: Container(
                          color: Color.fromARGB(255, 122, 18, 35),
                        )),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      'VIP',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Color.fromARGB(255, 139, 127, 87),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                  width: 5.w,
                  height: 5.w,
                  child: Container(
                    color: Color.fromARGB(255, 139, 127, 87),
                  )),
              const SizedBox(
                width: 2,
              ),
              Text(
                'Standard',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Color.fromARGB(255, 139, 127, 87),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CrossDrawPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint crossBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), crossBrush);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), crossBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
