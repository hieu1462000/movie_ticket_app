import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MovieList extends StatelessWidget {
  final String listName;
  final Widget listChild;
  const MovieList({Key? key, required this.listName, required this.listChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 3.w, right: 3.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(bottom: 1.w, left: 1.w),
          child: Text(
            listName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontSize: 14.sp),
          ),
        ),
        SizedBox(height: 31.h, child: listChild),
      ]),
    );
  }
}
