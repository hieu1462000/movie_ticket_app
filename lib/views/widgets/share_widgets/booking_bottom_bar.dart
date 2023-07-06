import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class BookingBottomBar extends StatelessWidget {
  final String movieTitle;
  final String movieRated;
  final String movieFormat;
  final int bookingPrice;
  final int numberOfSeat;
  final String? snacks;
  final void Function() onTap;
  const BookingBottomBar(
      {Key? key,
      required this.movieTitle,
      required this.movieRated,
      required this.movieFormat,
      required this.bookingPrice,
      required this.numberOfSeat,
      required this.snacks,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.black,
          border:
              Border(top: BorderSide(color: Color.fromARGB(255, 94, 93, 93)))),
      height: 10.h,
      child: Padding(
        padding: EdgeInsets.only(left: 3.w, top: 1.w, right: 3.w),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 2.w),
                          child: Text(
                            movieTitle,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 8.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color.fromARGB(255, 150, 3, 3),
                              )),
                          child: Center(
                            child: Text(
                              movieRated,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 150, 3, 3),
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ]),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 1.w),
                  child: Text(
                    movieFormat,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      NumberFormat.simpleCurrency(
                              locale: 'vi-VN', decimalDigits: 0)
                          .format(bookingPrice),
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 2.w),
                        child: Row(
                          children: [
                            numberOfSeat < 2
                                ? Text(
                                    "$numberOfSeat seat",
                                    style: TextStyle(
                                        fontSize: 9.sp,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "$numberOfSeat seats",
                                    style: TextStyle(
                                        fontSize: 9.sp,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                            if (snacks != null && snacks!.isNotEmpty)
                              SizedBox(
                                width: 40.w,
                                child: Text(
                                  " + $snacks",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 9.sp,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                          ],
                        ))
                  ],
                ),
              ],
            )),
            if (numberOfSeat > 0)
              GestureDetector(
                onTap: onTap,
                child: Container(
                    height: 6.w,
                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 150, 3, 3),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Center(
                      child: Text(
                        "Book Now",
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              )
          ],
        ),
      ),
    );
  }
}
