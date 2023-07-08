import 'package:flutter/material.dart';
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
