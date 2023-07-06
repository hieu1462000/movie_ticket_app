import 'package:flutter/material.dart';
import 'package:movie_ticket/views/widgets/home_recommended_list.dart';
import 'package:sizer/sizer.dart';

class AppBarBackground extends StatelessWidget {
  final String imagePath;

  const AppBarBackground(this.imagePath, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.fill,
        ),
        Positioned.fill(
          child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 7.h,
                width: 100.w,
                color: Color.fromARGB(255, 24, 6, 6),
              )),
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black54, Colors.transparent],
            ),
          ),
        ),
        const Positioned.fill(
          child: Align(
              alignment: Alignment.bottomCenter, child: RecommendedList()),
        ),
      ],
    );
  }
}
