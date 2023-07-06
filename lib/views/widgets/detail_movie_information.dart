import 'package:flutter/material.dart';
import 'package:movie_ticket/models/movie_model.dart';
import 'package:sizer/sizer.dart';

class MovieDetail extends StatelessWidget {
  final String ratedSymbol;
  final String ratedDetail;
  final List<Genre> genres;
  final List<String> casts;
  final String director;
  final String language;

  const MovieDetail(
      {Key? key,
      required this.ratedSymbol,
      required this.ratedDetail,
      required this.genres,
      required this.casts,
      required this.director,
      required this.language})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String listGenre =
        genres.map((genre) => genre.name).toList().join(", ");
    final String listCast = casts.join(", ");
    return Padding(
      padding: EdgeInsets.all(3.w),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1.5),
          1: FlexColumnWidth(6),
        },
        children: [
          TableRow(children: [
            Text(
              "Rated",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.sp),
            ),
            Text(
              "$ratedSymbol - $ratedDetail",
              style: TextStyle(color: Colors.grey, fontSize: 10.sp),
            ),
          ]),
          TableRow(children: [
            Text(
              "Genre",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.sp),
            ),
            Text(
              listGenre,
              style: TextStyle(color: Colors.grey, fontSize: 10.sp),
            )
          ]),
          TableRow(children: [
            Text(
              "Director",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.sp),
            ),
            Text(
              director,
              style: TextStyle(color: Colors.grey, fontSize: 10.sp),
            )
          ]),
          TableRow(children: [
            Text(
              "Cast",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.sp),
            ),
            Text(
              listCast,
              style: TextStyle(color: Colors.grey, fontSize: 10.sp),
            )
          ]),
          TableRow(children: [
            Text(
              "Language",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.sp),
            ),
            Text(
              language,
              style: TextStyle(color: Colors.grey, fontSize: 10.sp),
            )
          ]),
        ],
      ),
    );
  }
}
