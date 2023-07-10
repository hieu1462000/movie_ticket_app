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
    final ticketWidth = 90.w;
    final ticketHeight = 14.h;
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: SizedBox(
              width: ticketWidth,
              height: ticketHeight,
              child: ClipPath(
                clipper: SmallTicketClipper(
                    clipRadius: ticketHeight * 0.5 * 0.25,
                    smallClipRadius: ticketHeight * 0.04,
                    numberOfSmallClipOffets:
                        ticketHeight ~/ (ticketHeight * 0.04)),
                child: Container(
                  color: Colors.white.withOpacity(0.8),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 2.w, bottom: 2.w, left: 2.w, right: 4.w),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 1.w),
                              child: Text(
                                movieTitle,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 0.5.w),
                              child: Text(
                                date,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.grey.shade900,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 1.5.w),
                              child: Text(
                                theaterName,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.grey.shade700,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.tickets,
                                  size: 14.sp,
                                  color: const Color.fromARGB(255, 158, 21, 11),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 1.w),
                                  child: Text(
                                    ticketId!.substring(8),
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: const Color.fromARGB(
                                          255, 158, 21, 11),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                        Text(
                          NumberFormat.simpleCurrency(
                                  locale: 'vi-VN', decimalDigits: 0)
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
              ),
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        )
      ],
    );
  }
}

class SmallTicketClipper extends CustomClipper<Path> {
  final double clipRadius;
  final double smallClipRadius;
  final int numberOfSmallClipOffets;

  const SmallTicketClipper(
      {required this.clipRadius,
      required this.smallClipRadius,
      required this.numberOfSmallClipOffets});
  @override
  Path getClip(Size size) {
    var path = Path();
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final clipPath = Path();
    clipPath.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height / 2), radius: clipRadius));

    final smallRightClipOffsets =
        List.generate(numberOfSmallClipOffets, (index) {
      final boxX = smallClipRadius * 2 * index;
      final centerX = boxX + smallClipRadius;
      return Offset(size.width, centerX);
    });

    smallRightClipOffsets.forEach((centerOffset) {
      clipPath.addOval(
          Rect.fromCircle(center: centerOffset, radius: smallClipRadius));
    });

    final smallLeftClipOffsets =
        List.generate(numberOfSmallClipOffets, (index) {
      final boxX = smallClipRadius * 2 * index;
      final centerX = boxX + smallClipRadius;
      return Offset(0, centerX);
    });

    smallLeftClipOffsets.forEach((centerOffset) {
      clipPath.addOval(
          Rect.fromCircle(center: centerOffset, radius: smallClipRadius));
    });

    final smallTicketPath = Path.combine(
      PathOperation.reverseDifference,
      clipPath,
      path,
    );

    return smallTicketPath;
  }

  @override
  bool shouldReclip(SmallTicketClipper oldClipper) {
    return oldClipper.clipRadius != clipRadius ||
        oldClipper.smallClipRadius != smallClipRadius ||
        oldClipper.numberOfSmallClipOffets != numberOfSmallClipOffets;
  }
}
