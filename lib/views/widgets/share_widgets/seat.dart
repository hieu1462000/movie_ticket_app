import 'package:flutter/material.dart';

class Seat extends StatelessWidget {
  final child;
  final backgroundColor;
  final ontapFunction;

  const Seat({Key? key, this.child, this.backgroundColor, this.ontapFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontapFunction,
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: Colors.black,
            )),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
