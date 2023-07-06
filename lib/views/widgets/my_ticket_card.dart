import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyTicketCard extends StatelessWidget {
  final String movieTitle;
  final String date;
  final String theaterName;
  final String? ticketId;
  final int totalPrice;
  final void Function() onTap;

  const MyTicketCard(
      {super.key,
      required this.movieTitle,
      required this.date,
      required this.theaterName,
      required this.ticketId,
      required this.totalPrice,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color.fromARGB(255, 94, 93, 93))),
        height: 10.h,
        child: Padding(
          padding: EdgeInsets.all(2.w),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 3.w),
                    child: Text(
                      movieTitle,
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 1.w),
                    child: Text(
                      date,
                      style: TextStyle(
                          fontSize: 9.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.w),
                    child: Text(
                      theaterName,
                      style: TextStyle(
                          fontSize: 9.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.tickets,
                        size: 9.sp,
                        color: Color.fromARGB(255, 182, 30, 20),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 1.w),
                        child: Text(
                          ticketId!.substring(8),
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: Color.fromARGB(255, 182, 30, 20),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )),
              Text(
                NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0)
                    .format(totalPrice),
                style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
