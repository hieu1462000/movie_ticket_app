import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class BillCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String rated;
  final DateTime date;
  final String startTime;
  final String endingTime;
  final String theaterName;
  final List<String> seats;
  final String? snacks;
  final int totalPayment;
  const BillCard(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.rated,
      required this.date,
      required this.startTime,
      required this.endingTime,
      required this.theaterName,
      required this.seats,
      required this.snacks,
      required this.totalPayment})
      : super(key: key);

  @override
  State<BillCard> createState() => _BillCardState();
}

class _BillCardState extends State<BillCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Container(
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 25.w,
              height: 20.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.imagePath), fit: BoxFit.fill)),
            ),
            Padding(
              padding: EdgeInsets.all(2.w),
              child: SizedBox(
                width: 70.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 60.w,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 1.w),
                                  child: Text(
                                    widget.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ])),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        DateFormat('EEEE, MMM d, yyyy').format(widget.date),
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        "${widget.startTime} ~ ${widget.endingTime}",
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        widget.theaterName,
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        widget.seats.join(", "),
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 3.h),
                      child: Text(
                        widget.snacks ?? "",
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "Total payment: ${NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0).format(widget.totalPayment)}",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Color.fromARGB(255, 175, 21, 11),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
