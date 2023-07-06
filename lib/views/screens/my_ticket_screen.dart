import 'package:flutter/material.dart';
import 'package:movie_ticket/views/widgets/my_ticket_card.dart';
import 'package:sizer/sizer.dart';
import '../../model_views/booking_service.dart';
import '../widgets/share_widgets/app_bar.dart';
import '../widgets/share_widgets/drawer.dart';
import 'package:provider/provider.dart';

class MyTicketScreen extends StatefulWidget {
  const MyTicketScreen({Key? key}) : super(key: key);

  @override
  State<MyTicketScreen> createState() => _MyTicketScreenState();
}

class _MyTicketScreenState extends State<MyTicketScreen> {
  @override
  Widget build(BuildContext context) {
    BookingService bookingService = Provider.of<BookingService>(context);
    final listTicket = bookingService.listTicket;
    return listTicket.isNotEmpty
        ? Scaffold(
            backgroundColor: Colors.black,
            endDrawer: DrawerWidget(),
            body: CustomScrollView(
              slivers: [
                AppBarWidget(
                  leadingWidget: Icon(
                    Icons.adaptive.arrow_back,
                    size: 8.w,
                    color: Colors.white,
                  ),
                  leadingOnnClick: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                  titleWidget: Text(
                    'My Ticket',
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                  isCenter: false,
                  expandedHeight: 0,
                ),
                SliverPadding(
                    padding: EdgeInsets.all(3.w),
                    sliver: SliverFixedExtentList(
                        itemExtent: 35.w,
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => MyTicketCard(
                                onTap: () {
                                  print(listTicket[index].snack);
                                },
                                movieTitle: listTicket[index].movieTitle,
                                date: listTicket[index].date,
                                theaterName: listTicket[index].theater,
                                ticketId: listTicket[index].id,
                                totalPrice: listTicket[index].totalPrice),
                            childCount: listTicket.length)))
              ],
            ))
        : Scaffold(
            backgroundColor: Colors.black,
            endDrawer: DrawerWidget(),
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
            ]));
  }
}
