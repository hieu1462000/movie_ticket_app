import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyTicketInformation extends StatelessWidget {
  final String imagePath;
  final String movieTitle;
  final String date;
  final String time;
  final int runtime;
  final String cinema;
  final List<String> seatList;
  final String snack;

  const MyTicketInformation({
    super.key,
    required this.imagePath,
    required this.movieTitle,
    required this.date,
    required this.time,
    required this.runtime,
    required this.cinema,
    required this.seatList,
    required this.snack,
  });

  String estimateEndingTime(String startTime, int runtime) {
    int startHour = int.parse(startTime.substring(0, 2));
    int startMin = int.parse(startTime.substring(3));
    int ending = startHour * 60 + startMin + runtime;
    int endingHour = ending ~/ 60;
    int endingMin = ending.remainder(60);
    if (endingHour >= 24) {
      endingHour = endingHour - 24;
    }
    if (endingHour < 10 && endingMin < 10) {
      return "0$endingHour:0$endingMin";
    } else if (endingHour < 10 && endingMin > 10) {
      return "0$endingHour:$endingMin";
    } else if (endingHour > 10 && endingMin < 10) {
      return "$endingHour:0$endingMin";
    } else {
      return "$endingHour:$endingMin";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 2.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 25.w,
            height: 20.h,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imagePath), fit: BoxFit.fill)),
          ),
          SizedBox(
            width: 62.w,
            child: Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 60.w,
                              child: Padding(
                                padding: EdgeInsets.only(right: 1.w),
                                child: Text(
                                  movieTitle,
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
                    padding: EdgeInsets.only(bottom: 1.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 1.w),
                                child: Text(
                                  date,
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                              SizedBox(
                                  height: 4.h,
                                  child: const VerticalDivider(
                                    color: Colors.black,
                                  ))
                            ],
                          ),
                        ),
                        Text(
                          "$time ~ ${estimateEndingTime(time, runtime)}",
                          style: TextStyle(
                              fontSize: 10.sp, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 1.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.movie,
                          size: 13.sp,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 1.w),
                          child: Text(
                            cinema,
                            style: TextStyle(
                                fontSize: 10.sp, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 1.h),
                    child: Row(
                      children: [
                        Icon(Icons.chair, size: 13.sp),
                        SizedBox(
                          width: 55.w,
                          child: Padding(
                            padding: EdgeInsets.only(left: 1.w),
                            child: Text(
                              seatList.join(', '),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 10.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (snack.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.fastfood,
                            size: 13.sp,
                          ),
                          SizedBox(
                            width: 55.w,
                            child: Padding(
                              padding: EdgeInsets.only(left: 1.w),
                              child: Text(
                                snack,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
