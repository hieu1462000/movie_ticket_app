import 'package:flutter/material.dart';
import 'package:movie_ticket/views/widgets/detail_my_ticket_background.dart';
import 'package:movie_ticket/views/widgets/detail_my_ticket_information.dart';
import 'package:movie_ticket/views/widgets/detail_my_ticket_price.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

import '../../model_views/booking_service.dart';
import '../widgets/share_widgets/app_bar.dart';

class DetailTicketScreen extends StatefulWidget {
  const DetailTicketScreen({super.key});

  @override
  State<DetailTicketScreen> createState() => _DetailTicketScreenState();
}

class _DetailTicketScreenState extends State<DetailTicketScreen> {
  @override
  Widget build(BuildContext context) {
    BookingService bookingService = Provider.of<BookingService>(context);
    final ticket = bookingService.ticketDetail;
    return ticket != null
        ? Scaffold(
            backgroundColor: Colors.black,
            body: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                AppBarWidget(
                  leadingWidget: Icon(
                    Icons.adaptive.arrow_back,
                    size: 8.w,
                    color: Colors.white,
                  ),
                  leadingOnnClick: () {
                    Navigator.of(context).pop();
                  },
                  titleWidget: Text(
                    'My Ticket',
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                  isCenter: false,
                  expandedHeight: 0,
                ),
                SliverToBoxAdapter(
                  child: DetailTicketBackground(
                      content: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyTicketInformation(
                          imagePath: ticket.posterPath,
                          movieTitle: ticket.movieTitle,
                          date: ticket.date,
                          time: ticket.showtime,
                          runtime: ticket.runtime,
                          cinema: ticket.theater,
                          seatList: ticket.seat,
                          snack: ticket.snack),
                      SizedBox(height: 5.h),
                      MyTicketPrice(
                          ticketPrice: ticket.ticketPrice,
                          concession: ticket.snackPrice,
                          paymentMethod: ticket.paymentMethod,
                          total: ticket.totalPrice),
                      //SizedBox(height: 5.h),
                      //QR code
                      Container(
                        alignment: Alignment.center,
                        height: 40.w,
                        width: 40.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: const Text(
                          "QR code is here!",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: Text(
                          ticket.id!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10.sp),
                        ),
                      )
                    ],
                  )),
                )
              ],
            ),
          )
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
                  Navigator.of(context).pop();
                },
                titleWidget: Text(
                  'My Ticket',
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
                isCenter: false,
                expandedHeight: 0,
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40.w,
                        width: 45.w,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/onlypopcorn.png'),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: const Text(
                          "There is no data",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]));
  }
}
