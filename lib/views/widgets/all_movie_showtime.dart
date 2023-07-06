import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../model_views/booking_service.dart';

class AllMovieShowtime extends StatefulWidget {
  final String date;
  const AllMovieShowtime({Key? key, required this.date}) : super(key: key);

  @override
  State<AllMovieShowtime> createState() => _AllMovieShowtimeState();
}

class _AllMovieShowtimeState extends State<AllMovieShowtime> {
  @override
  void initState() {
    BookingService bookingService =
        Provider.of<BookingService>(context, listen: false);
    bookingService.getListShowtimeFromApi(widget.date);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    BookingService bookingService =
        Provider.of<BookingService>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.date != bookingService.currentDate) {
        //avoid calling didChangeDependencies repeatedly
        bookingService.getListShowtimeFromApi(widget.date);
        bookingService.currentDate = widget.date;
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    BookingService bookingService = Provider.of<BookingService>(context);
    final listShowtime = bookingService.listShowtime;
    return listShowtime.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
            children: List.generate(
                listShowtime.length,
                (movieIndex) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 4.w, left: 3.w, top: 2.h),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 2.w),
                                    child: Text(
                                      listShowtime[movieIndex].movie.title,
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
                                        listShowtime[movieIndex]
                                            .movie
                                            .ratedReference
                                            .symbol,
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
                            children: List.generate(
                                listShowtime[movieIndex].formats.length,
                                (formatIndex) {
                              return Padding(
                                padding:
                                    EdgeInsets.only(bottom: 4.w, left: 3.w),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              listShowtime[movieIndex]
                                                  .formats[formatIndex]
                                                  .name,
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
                                          itemCount: listShowtime[movieIndex]
                                              .formats[formatIndex]
                                              .showtimes
                                              .length,
                                          itemBuilder:
                                              (context, showtimeIndex) {
                                            return GestureDetector(
                                              onTap: () {
                                                bookingService
                                                        .selectedShowtimeId =
                                                    listShowtime[movieIndex]
                                                        .formats[formatIndex]
                                                        .showtimes[
                                                            showtimeIndex]
                                                        .id;
                                                Navigator.of(context)
                                                    .pushNamed('/booking');
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  right: 2.w,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              66, 77, 77, 77),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
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
                                                      listShowtime[movieIndex]
                                                          .formats[formatIndex]
                                                          .showtimes[
                                                              showtimeIndex]
                                                          .time,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                        ])),
          ))
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
