import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../model_views/booking_service.dart';

class SingleMovieShowtime extends StatefulWidget {
  final String date;
  final String movieId;
  const SingleMovieShowtime(
      {Key? key, required this.date, required this.movieId})
      : super(key: key);

  @override
  State<SingleMovieShowtime> createState() => _SingleMovieShowtimeState();
}

class _SingleMovieShowtimeState extends State<SingleMovieShowtime> {
  @override
  void initState() {
    // BookingService bookingService =
    //     Provider.of<BookingService>(context, listen: false);
    // bookingService.getShowtimesByMovie(widget.date, widget.movieId);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    BookingService bookingService =
        Provider.of<BookingService>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.date != bookingService.currentDate) {
        //avoid calling didChangeDependencies repeatedly
        bookingService.getShowtimesByMovie(widget.date, widget.movieId);
        bookingService.currentDate = widget.date;
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    BookingService bookingService = Provider.of<BookingService>(context);
    final showtime = bookingService.showtimesOfMovie;
    return showtime.isNotEmpty
        ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(bottom: 4.w, left: 3.w, top: 2.h),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 2.w),
                      child: Text(
                        showtime[0].movie.title,
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: 8.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.red,
                          )),
                      child: Center(
                        child: Text(
                          showtime[0].movie.ratedReference.symbol,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ]),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(showtime[0].formats.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 4.w, left: 3.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.w),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle_outlined,
                                size: 10.sp,
                                color: Colors.orange,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Text(
                                showtime[0].formats[index].name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 6.w,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                showtime[0].formats[index].showtimes.length,
                            itemBuilder: (context, listIndex) {
                              return GestureDetector(
                                onTap: () {
                                  print(showtime[0]
                                      .formats[index]
                                      .showtimes[listIndex]
                                      .id);
                                  bookingService.selectedShowtimeId =
                                      showtime[0]
                                          .formats[index]
                                          .showtimes[listIndex]
                                          .id;
                                  Navigator.of(context).pushNamed('/booking');
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: 2.w,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(66, 77, 77, 77),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Colors.grey,
                                        )),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 1.w,
                                          bottom: 1.w,
                                          left: 3.w,
                                          right: 3.w),
                                      child: Text(
                                        showtime[0]
                                            .formats[index]
                                            .showtimes[listIndex]
                                            .time,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ]),
                );
              }),
            ),
            const Divider(color: Colors.grey),
          ])
        : Container(
            padding: EdgeInsets.only(top: 1.h),
            child: const Center(
              child: Text(
                'None of season.',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          );
  }
}
