import 'package:flutter/material.dart';
import 'package:movie_ticket/model_views/movie_service.dart';
import 'package:movie_ticket/views/widgets/advertisement_list.dart';
import 'package:movie_ticket/views/widgets/detail_movie_information.dart';
import 'package:movie_ticket/views/widgets/detail_movie_trailer.dart';
import 'package:movie_ticket/views/widgets/share_widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../model_views/booking_service.dart';
import '../widgets/share_widgets/drawer.dart';

class DetailMovieScreen extends StatefulWidget {
  const DetailMovieScreen({Key? key}) : super(key: key);

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // MovieService movieService =
    //     Provider.of<MovieService>(context, listen: false);
    // movieService.getDetailMovieFromApi(movieService.selectedMovieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MovieService movieService = Provider.of<MovieService>(context);
    BookingService bookingService =
        Provider.of<BookingService>(context, listen: false);
    final currentMovie = movieService.selectedMovie;
    return currentMovie != null
        ? Scaffold(
            backgroundColor: Colors.black,
            endDrawer: DrawerWidget(),
            body: Stack(children: [
              CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  AppBarWidget(
                    leadingWidget: Icon(
                      Icons.adaptive.arrow_back,
                      size: 8.w,
                      color: Colors.white,
                    ),
                    leadingOnnClick: () async {
                      movieService.selectedMovie = null;
                      movieService.selectedMovieId = "";
                      Navigator.of(context).pop();
                    },
                    titleWidget: Text(
                      'Movie',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                    isCenter: false,
                    expandedHeight: 0,
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    MovieTrailer(
                        trailerId: currentMovie.trailer,
                        posterPath: currentMovie.posterPath,
                        title: currentMovie.title,
                        releaseDate: currentMovie.releaseDate,
                        runtime: currentMovie.runtime,
                        overview: currentMovie.overview),
                    const Divider(color: Colors.grey),
                    MovieDetail(
                        ratedSymbol: currentMovie.rated.symbol,
                        ratedDetail: currentMovie.rated.description,
                        genres: currentMovie.genres,
                        casts: currentMovie.cast,
                        director: currentMovie.director,
                        language: currentMovie.language),
                    const Divider(color: Colors.grey),
                    const AdvertisementList(),
                    SizedBox(
                      height: 7.h,
                    )
                  ]))
                ],
              ),
              if (currentMovie.isReleased == true)
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Theme(
                        data: Theme.of(context)
                            .copyWith(canvasColor: Colors.transparent),
                        child: GestureDetector(
                          onTap: (() async {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Color.fromARGB(255, 141, 19, 11),
                                    ),
                                  );
                                });
                            movieService.selectedMovie = currentMovie;
                            movieService.selectedMovieId = currentMovie.id;
                            await bookingService.getShowtimesByMovie(
                                bookingService.selectedDate,
                                movieService.selectedMovieId);

                            await Future.delayed(
                                const Duration(milliseconds: 200));
                            if (!mounted) return;
                            Navigator.of(context).pop();
                            bookingService.isSigleMovie = true;
                            Navigator.of(context).pushNamed("/showtime");
                          }),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 8.w, right: 8.w, bottom: 1.h),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 150, 3, 3),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                height: 5.h,
                                child: const Center(
                                  child: Text(
                                    "BOOK NOW",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
                        ))),
            ]),
          )
        : Scaffold(
            backgroundColor: Colors.black,
            body: Container(),
          );
  }
}
