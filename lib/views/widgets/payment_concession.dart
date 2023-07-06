import 'package:flutter/material.dart';
import 'package:movie_ticket/models/selected_snacks_model.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class Concession extends StatelessWidget {
  final List<SelectedSnacks> selectedSnacks;
  final int subTotal;

  const Concession(
      {Key? key, required this.selectedSnacks, required this.subTotal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Text(
              "CONCESSION (OPTIONAL)",
              style: TextStyle(color: Colors.grey, fontSize: 12.sp),
            ),
          ),
          Column(
            children: List.generate(
                selectedSnacks.length,
                (index) => Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          border:
                              Border(bottom: BorderSide(color: Colors.grey))),
                      padding: EdgeInsets.all(2.w),
                      child: Row(
                        children: [
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: 8.w,
                                  width: 8.w,
                                  child: Image.network(
                                      selectedSnacks[index].imagePath)),
                              Text(
                                selectedSnacks[index].name,
                                style: TextStyle(fontSize: 11.sp),
                              )
                            ],
                          )),
                          Text(
                            "${selectedSnacks[index].quantity}",
                            style: TextStyle(fontSize: 11.sp),
                          )
                        ],
                      ),
                    )),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(2.w),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  "Subtotal",
                  style: TextStyle(fontSize: 11.sp),
                )),
                Text(
                  NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0)
                      .format(subTotal),
                  style: TextStyle(fontSize: 11.sp),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
