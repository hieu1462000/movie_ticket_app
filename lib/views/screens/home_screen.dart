import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket/views/widgets/home_coming_soon.dart';
import 'package:movie_ticket/views/widgets/home_now_showing.dart';
import 'package:movie_ticket/views/widgets/share_widgets/app_bar.dart';
import 'package:movie_ticket/views/widgets/home_special_list.dart';
import 'package:movie_ticket/views/widgets/share_widgets/drawer.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../model_views/booking_service.dart';
import '../widgets/share_widgets/app_bar_background.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        endDrawer: DrawerWidget(),
        body: CustomScrollView(
          slivers: [
            AppBarWidget(
              leadingWidget: GestureDetector(
                onTap: () async {
                  BookingService bookingService =
                      Provider.of<BookingService>(context, listen: false);
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
                  await bookingService.getListTicketFromApi(user.uid);
                  //await Future.delayed(const Duration(seconds: 1));
                  if (!mounted) return;
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/ticket');
                },
                child: Icon(
                  CupertinoIcons.tickets_fill,
                  size: 7.w,
                  color: Colors.white,
                ),
              ),
              leadingOnnClick: () {},
              titleWidget: Image.asset('assets/images/netflix.png'),
              isCenter: true,
              flexibleSpaceBar: const FlexibleSpaceBar(
                background: AppBarBackground("assets/images/bat1.jpeg"),
              ),
              expandedHeight: 25.h,
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              GestureDetector(
                onTap: (() {
                  //bookingService.isSingleMovie = false;
                  Navigator.of(context).pushNamed("/showtime");
                }),
                child: Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.w),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 150, 3, 3),
                        borderRadius: BorderRadius.circular(10.0),
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.w),
                child: const SpecialList(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.w),
                child: const NowShowingList(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.w),
                child: const ComingsoonList(),
              ),
            ]))
          ],
        ));
  }
}
