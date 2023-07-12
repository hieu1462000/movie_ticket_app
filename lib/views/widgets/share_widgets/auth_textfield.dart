import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AuthTextField extends StatelessWidget {
  final hintText;
  final suffix;
  final validator;
  final obscureText;
  final onChanged;
  final controller;

  const AuthTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.suffix,
      required this.obscureText,
      required this.validator,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white10,
              blurRadius: 25,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: TextFormField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 6.w,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade800),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.black,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[800]),
              suffix: suffix,
            ),
            validator: validator,
            obscureText: obscureText,
            onChanged: onChanged),
      ),
    );
  }
}
