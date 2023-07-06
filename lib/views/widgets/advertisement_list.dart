import 'package:flutter/material.dart';
import 'package:movie_ticket/model_views/movie_service.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class AdvertisementList extends StatefulWidget {
  const AdvertisementList({
    Key? key,
  }) : super(key: key);

  @override
  State<AdvertisementList> createState() => _AdvertisementListState();
}

class _AdvertisementListState extends State<AdvertisementList> {
  @override
  void initState() {
    MovieService movieService =
        Provider.of<MovieService>(context, listen: false);
    movieService.getListAdvertisementFromApi();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MovieService movieService = Provider.of<MovieService>(context);
    final listAd = movieService.listAdvertisement;
    return listAd.isNotEmpty
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 3.w, left: 3.w),
                  child: Text(
                    "News & Offers",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14.sp),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                  child: Padding(
                    padding: EdgeInsets.only(left: 3.w),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listAd.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          movieService.selectedAdId = listAd[index].id;
                          Navigator.of(context).pushNamed('/ad');
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 3.w),
                          child: Container(
                            width: 60.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image:
                                        NetworkImage(listAd[index].posterPath),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : Container();
  }
}
