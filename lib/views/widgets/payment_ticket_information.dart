import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class TicketInformation extends StatelessWidget {
  final int quantity;
  final int subTotal;

  const TicketInformation(
      {Key? key, required this.quantity, required this.subTotal})
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
              "TICKET INFORMATION",
              style: TextStyle(color: Colors.grey, fontSize: 12.sp),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey))),
            padding: EdgeInsets.all(2.w),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  "Quantity",
                  style: TextStyle(fontSize: 11.sp),
                )),
                Text(
                  "$quantity",
                  style: TextStyle(fontSize: 11.sp),
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(2.w),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  "Subtotal",
                  style: TextStyle(fontSize: 10.sp),
                )),
                Text(
                  NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0)
                      .format(subTotal),
                  style: TextStyle(fontSize: 10.sp),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
