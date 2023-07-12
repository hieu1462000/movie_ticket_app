import 'package:flutter/material.dart';
import 'package:movie_ticket/views/widgets/showtime_all_movie.dart';
import 'package:movie_ticket/views/widgets/showtime_single_movie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../../model_views/booking_service.dart';
import '../../model_views/movie_service.dart';
import '../widgets/share_widgets/app_bar.dart';
import '../widgets/share_widgets/drawer.dart';

class ShowtimeScreen extends StatefulWidget {
  const ShowtimeScreen({Key? key}) : super(key: key);

  @override
  State<ShowtimeScreen> createState() => _ShowtimeScreenState();
}

class _ShowtimeScreenState extends State<ShowtimeScreen> {
  int selectedDateIndex = 0;
  DateTime currentDate = DateTime(2023, 5, 27); //pseudo current day
  String formattedDate = DateFormat('yyyy-MM-dd')
      .format(DateTime(2023, 5, 27)); //have the same format with movie
  String detailDate =
      DateFormat('EEEE MMM d, yyyy').format(DateTime(2023, 5, 27));

  @override
  void initState() {
    //bookingService.selectedDate = formattedDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BookingService bookingService = Provider.of<BookingService>(context);
    final currentMovie =
        Provider.of<MovieService>(context, listen: false).selectedMovie;
    return Scaffold(
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
              if (currentMovie != null) {
                Navigator.of(context).pop();
              } else {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              }
            },
            titleWidget: Text(
              currentMovie != null ? currentMovie.title : "Showtime",
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
            isCenter: false,
            expandedHeight: 0,
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.w),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      child: Row(
                        children: List.generate(
                          14,
                          (index) {
                            final selectedDate =
                                currentDate.add(Duration(days: index));
                            final dayName =
                                DateFormat('E').format(selectedDate);
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: index == 0 ? 2.w : 0.0, right: 7.4.w),
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  selectedDateIndex = index;
                                  formattedDate = DateFormat('yyyy-MM-dd')
                                      .format(selectedDate);
                                  detailDate = DateFormat('EEEE MMM d, yyyy')
                                      .format(selectedDate);
                                  bookingService.selectedDate = formattedDate;
                                  bookingService.bookingDate = selectedDate;
                                }),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 7.w,
                                      width: 7.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: selectedDateIndex == index
                                            ? const Color.fromARGB(
                                                255, 173, 5, 5)
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(44.0),
                                      ),
                                      child: Text(
                                        dayName.substring(0, 1),
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: selectedDateIndex == index
                                              ? Colors.white
                                              : Colors.black54,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 3.w),
                                    Text(
                                      "${selectedDate.day}",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 1.w),
                                    Container(
                                      height: 2.0,
                                      width: 7.w,
                                      color: selectedDateIndex == index
                                          ? const Color.fromARGB(255, 173, 5, 5)
                                          : Colors.transparent,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Center(
                        child: Text(
                      detailDate,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Provider.of<MovieService>(context)
                      .selectedMovieId
                      .isNotEmpty
                  ? SingleMovieShowtime(
                      date: bookingService.selectedDate,
                      movieId:
                          Provider.of<MovieService>(context).selectedMovieId,
                    )
                  : AllMovieShowtime(
                      date: bookingService.selectedDate,
                    ))
        ]));
  }
}
