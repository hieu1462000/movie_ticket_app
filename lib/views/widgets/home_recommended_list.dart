import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_ticket/model_views/movie_service.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RecommendedList extends StatefulWidget {
  const RecommendedList({
    Key? key,
  }) : super(key: key);

  @override
  State<RecommendedList> createState() => _RecommendedListState();
}

class _RecommendedListState extends State<RecommendedList> {
  @override
  void initState() {
    MovieService movieService =
        Provider.of<MovieService>(context, listen: false);
    movieService.getListRecommendedFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MovieService movieService = Provider.of<MovieService>(context);
    final listRec = movieService.listRecommended;
    return CarouselSlider.builder(
      itemCount: listRec.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          GestureDetector(
        onTap: () async {
          if (listRec[itemIndex].type == 'advertisement') {
            movieService.selectedAdId = listRec[itemIndex].id;
            Navigator.of(context).pushNamed('/ad');
          } else {
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
            await movieService.getDetailMovieFromApi(listRec[itemIndex].id);
            movieService.selectedMovieId = listRec[itemIndex].id;
            await Future.delayed(const Duration(milliseconds: 500));
            if (!mounted) return;
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed("/movie");
          }
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(listRec[itemIndex].posterPath),
                  fit: BoxFit.cover)),
        ),
      ),
      options: CarouselOptions(
        height: 17.h,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 1,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: false,
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        viewportFraction: 0.6,
      ),
    );
  }
}
