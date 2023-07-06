import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

import '../../model_views/booking_service.dart';

class BankPayment extends StatefulWidget {
  const BankPayment({Key? key}) : super(key: key);

  @override
  State<BankPayment> createState() => _BankPaymentState();
}

class _BankPaymentState extends State<BankPayment> {
  List<String> paymentLogoPaths = [
    'https://cdn-icons-png.flaticon.com/512/5859/5859423.png',
    'https://cdn4.iconfinder.com/data/icons/logos-and-brands/512/363_Visa_Credit_Card_logo-512.png',
    'https://upload.wikimedia.org/wikipedia/vi/f/fe/MoMo_Logo.png',
    'https://cdn.haitrieu.com/wp-content/uploads/2022/10/Logo-ShopeePay-V.png',
    'https://cdn.haitrieu.com/wp-content/uploads/2022/10/Logo-ZaloPay-Square.png'
  ];

  List<String> paymentTitle = [
    'ATM card',
    'Credit card',
    'Momo',
    'ShopeePay',
    'ZaloPay',
  ];

  List<bool> paymentSelectedController = [
    true,
    false,
    false,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    BookingService bookingService =
        Provider.of<BookingService>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Text(
              "BANK PAYMENT",
              style: TextStyle(color: Colors.grey, fontSize: 12.sp),
            ),
          ),
          Column(
            children: List.generate(
              paymentTitle.length,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    for (int i = 0; i < paymentSelectedController.length; i++) {
                      paymentSelectedController[i] = false;
                    }
                    paymentSelectedController[index] = true;
                  });
                  bookingService.paymentMethod = paymentTitle[index];
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(bottom: BorderSide(color: Colors.grey))),
                  padding: EdgeInsets.all(1.w),
                  child: Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          SizedBox(
                            width: 8.w,
                            height: 8.w,
                            child: Image.network(paymentLogoPaths[index]),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: Text(
                              paymentTitle[index],
                              style: TextStyle(fontSize: 11.sp),
                            ),
                          ),
                        ],
                      )),
                      if (paymentSelectedController[index] == true)
                        Icon(
                          Icons.check,
                          size: 14.sp,
                          color: Colors.black,
                        )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
