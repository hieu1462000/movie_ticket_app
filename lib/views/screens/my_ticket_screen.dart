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
              physics: BouncingScrollPhysics(),
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
                    padding: EdgeInsets.zero,
                    sliver: SliverFixedExtentList(
                        itemExtent: 16.h,
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => MyTicketCard(
                                onTap: () async {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: Color.fromARGB(
                                                255, 141, 19, 11),
                                          ),
                                        );
                                      });
                                  await bookingService.getDetailTicketFromApi(
                                      listTicket[index].id);
                                  await Future.delayed(
                                      const Duration(milliseconds: 500));
                                  if (!mounted) return;
                                  Navigator.of(context).pop();
                                  Navigator.of(context)
                                      .pushNamed("/detailTicket");
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
