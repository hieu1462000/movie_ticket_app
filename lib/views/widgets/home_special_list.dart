import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_ticket/model_views/movie_service.dart';
import 'share_widgets/movie_card.dart';
import 'package:sizer/sizer.dart';

class SpecialList extends StatefulWidget {
  const SpecialList({Key? key}) : super(key: key);

  @override
  State<SpecialList> createState() => _SpecialListState();
}

class _SpecialListState extends State<SpecialList> {
  @override
  void initState() {
    // TODO: implement initState
    MovieService movieService =
        Provider.of<MovieService>(context, listen: false);
    movieService.getSpecialListFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MovieService movieService = Provider.of<MovieService>(context);
    final list = movieService.specialList;
    return list != null
        ? Container(
            padding: EdgeInsets.only(left: 3.w, right: 3.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(bottom: 1.w, left: 1.w),
                child: Text(
                  list.listName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontSize: 14.sp),
                ),
              ),
              SizedBox(
                height: 31.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: list.movies.length,
                    itemBuilder: (context, index) {
                      return MovieCard(
                          title: list.movies[index].title,
                          posterPath: list.movies[index].posterPath,
                          ratedSymbol: list.movies[index].rated.symbol,
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Color.fromARGB(255, 141, 19, 11),
                                    ),
                                  );
                                });
                            await movieService
                                .getDetailMovieFromApi(list.movies[index].id);
                            movieService.selectedMovieId =
                                list.movies[index].id;
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            if (!mounted) return;
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed("/movie");
                          });
                    }),
              ),
            ]),
          )
        : Container();
  }
}
