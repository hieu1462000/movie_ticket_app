import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class MyTicketPrice extends StatelessWidget {
  final int ticketPrice;
  final int concession;
  final String paymentMethod;
  final int total;

  const MyTicketPrice(
      {super.key,
      required this.ticketPrice,
      required this.concession,
      required this.paymentMethod,
      required this.total});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 2.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 2.h),
            child: Row(
              children: [
                const Expanded(child: Text("Ticket Price:")),
                Text(NumberFormat.simpleCurrency(
                        locale: 'vi-VN', decimalDigits: 0)
                    .format(ticketPrice))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 2.h),
            child: Row(
              children: [
                const Expanded(child: Text("Concession:")),
                Text(NumberFormat.simpleCurrency(
                        locale: 'vi-VN', decimalDigits: 0)
                    .format(concession))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Row(
              children: [
                const Expanded(child: Text("Payment Method")),
                Text(paymentMethod)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: const Divider(
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 2.h),
            child: Row(
              children: [
                const Expanded(child: Text("Total:")),
                Text(NumberFormat.simpleCurrency(
                        locale: 'vi-VN', decimalDigits: 0)
                    .format(total))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
