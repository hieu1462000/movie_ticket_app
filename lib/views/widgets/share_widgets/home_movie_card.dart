import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String posterPath;
  final String ratedSymbol;
  final VoidCallback onTap;
  const MovieCard(
      {Key? key,
      required this.title,
      required this.posterPath,
      required this.ratedSymbol,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Card(
              color: Colors.black45,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.grey[700]!)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Container(
                          width: 32.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(posterPath),
                                  fit: BoxFit.fill)),
                        )),
                    SizedBox(
                      width: 32.w,
                      height: 9.h,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 2.w, right: 2.w, top: 3.h),
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ])),
          Positioned(
              left: 2.5.w,
              bottom: 8.h,
              child: Container(
                  height: 4.h,
                  width: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    border: Border.all(color: Colors.redAccent),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      ratedSymbol,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  )))
        ],
      ),
    );
  }
}
