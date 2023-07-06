import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:intl/intl.dart';

class SnackCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final int price;
  final String description;
  final int numberOfSnacks;
  final void Function()? onAddTap;
  final void Function()? onRemoveTap;

  SnackCard(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.price,
      required this.description,
      required this.numberOfSnacks,
      required this.onRemoveTap,
      required this.onAddTap})
      : super(key: key);

  @override
  State<SnackCard> createState() => _SnackCardState();
}

class _SnackCardState extends State<SnackCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Container(
        color: Colors.black,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
              height: 35.w,
              width: 35.w,
              child: Image.network(widget.imagePath)),
          Padding(
            padding: EdgeInsets.only(left: 2.w),
            child: SizedBox(
              width: 60.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      NumberFormat.simpleCurrency(
                              locale: 'vi-VN', decimalDigits: 0)
                          .format(widget.price),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      widget.description,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: widget.onRemoveTap,
                        child: Icon(
                          Icons.remove_circle_outline,
                          color: widget.numberOfSnacks == 0
                              ? Colors.grey
                              : Colors.white,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        "${widget.numberOfSnacks}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp),
                      ),
                      SizedBox(width: 2.w),
                      GestureDetector(
                        onTap: widget.onAddTap,
                        child: const Icon(
                          Icons.add_circle_outline,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
