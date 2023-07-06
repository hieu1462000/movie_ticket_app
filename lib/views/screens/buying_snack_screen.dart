import 'package:flutter/material.dart';
import 'package:movie_ticket/model_views/booking_service.dart';
import 'package:movie_ticket/models/selected_snacks_model.dart';
import 'package:movie_ticket/views/widgets/share_widgets/snack_card.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

import '../widgets/share_widgets/app_bar.dart';
import '../widgets/share_widgets/booking_bottom_bar.dart';

class SnackScreen extends StatefulWidget {
  const SnackScreen({Key? key}) : super(key: key);

  @override
  State<SnackScreen> createState() => _SnackScreenState();
}

class _SnackScreenState extends State<SnackScreen> {
  List<int> numberOfSnackList = [0, 0, 0, 0, 0, 0];

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

  @override
  void initState() {
    BookingService bookingService =
        Provider.of<BookingService>(context, listen: false);
    bookingService.getListSnackFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BookingService bookingService = Provider.of<BookingService>(context);
    final listSnack = bookingService.listSnack;
    final showtimeDetail = bookingService.showtimeDetail;
    return listSnack.isNotEmpty
        ? Scaffold(
            backgroundColor: Colors.black,
            //endDrawer: DrawerWidget(),
            bottomNavigationBar: BookingBottomBar(
              movieTitle: showtimeDetail!.movieReference.title,
              movieRated: showtimeDetail.movieReference.ratedReference.symbol,
              movieFormat: showtimeDetail.formatReference.name,
              bookingPrice: bookingService.bookingPrice,
              numberOfSeat: bookingService.numberOfSeats,
              snacks: bookingService.selectedSnacks,
              onTap: () {
                Navigator.of(context).pushNamed('/payment');
              },
            ),
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
                      showtimeDetail.movieReference.title,
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "${showtimeDetail.theater.name}  ${showtimeDetail.time} ~ ${estimateEndingTime(showtimeDetail.time, showtimeDetail.movieReference.runtime)}",
                      style: TextStyle(color: Colors.grey, fontSize: 9.sp),
                    ),
                  ],
                ),
                isCenter: false,
                expandedHeight: 0,
              ),
              SliverPadding(
                padding: EdgeInsets.all(2),
                sliver: SliverFixedExtentList(
                  itemExtent: 35.w,
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => SnackCard(
                            imagePath: listSnack[index].posterPath,
                            title: listSnack[index].title,
                            price: listSnack[index].price,
                            description: listSnack[index].description,
                            numberOfSnacks: numberOfSnackList[index],
                            onRemoveTap: numberOfSnackList[index] == 0
                                ? null
                                : () => {
                                      setState(
                                        () {
                                          numberOfSnackList[index]--;
                                          final price =
                                              bookingService.bookingPrice -
                                                  listSnack[index].price;
                                          bookingService.bookingPrice = price;
                                          bookingService.snackPrice =
                                              bookingService.bookingPrice -
                                                  bookingService.ticketPrice;
                                          bookingService.listSelectedSnacks
                                              .removeWhere((element) =>
                                                  element.name ==
                                                  listSnack[index].title);
                                          if (numberOfSnackList[index] > 0) {
                                            bookingService.listSelectedSnacks
                                                .add(SelectedSnacks(
                                                    name:
                                                        listSnack[index].title,
                                                    quantity: numberOfSnackList[
                                                        index],
                                                    imagePath: listSnack[index]
                                                        .posterPath));
                                          }
                                          final List<String> tmpList = [];
                                          for (int i = 0;
                                              i <
                                                  bookingService
                                                      .listSelectedSnacks
                                                      .length;
                                              i++) {
                                            final item =
                                                "${bookingService.listSelectedSnacks[i].name} x${bookingService.listSelectedSnacks[i].quantity}";
                                            tmpList.add(item);
                                          }
                                          bookingService.selectedSnacks =
                                              tmpList.join(", ");
                                          print(bookingService.selectedSnacks);
                                        },
                                      )
                                    },
                            onAddTap: () {
                              setState(() {
                                numberOfSnackList[index]++;
                                final price = bookingService.bookingPrice +
                                    listSnack[index].price;
                                bookingService.bookingPrice = price;
                                bookingService.snackPrice =
                                    bookingService.bookingPrice -
                                        bookingService.ticketPrice;
                                bookingService.listSelectedSnacks.removeWhere(
                                    (element) =>
                                        element.name == listSnack[index].title);
                                bookingService.listSelectedSnacks.add(
                                    SelectedSnacks(
                                        name: listSnack[index].title,
                                        quantity: numberOfSnackList[index],
                                        imagePath:
                                            listSnack[index].posterPath));

                                final List<String> tmpList = [];
                                for (int i = 0;
                                    i <
                                        bookingService
                                            .listSelectedSnacks.length;
                                    i++) {
                                  final item =
                                      "${bookingService.listSelectedSnacks[i].name}x${bookingService.listSelectedSnacks[i].quantity}";
                                  tmpList.add(item);
                                }
                                bookingService.selectedSnacks =
                                    tmpList.join(", ");
                                print(bookingService.selectedSnacks);
                              });
                            },
                          ),
                      childCount: listSnack.length),
                ),
              )
            ]))
        : Scaffold(
            backgroundColor: Colors.black,
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
                titleWidget: Text(
                  "Snack",
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                isCenter: false,
                expandedHeight: 0,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 104, 13, 6),
                  ),
                )
              ]))
            ]));
  }
}
